require 'addressable/uri'
require 'cgi'
require 'hpricot'
require 'net/http'
require 'net/https'
require 'open-uri'

# リンクチェック対象 URL
URL = "http://www.mk-mode.com/rails/"

# [CLASS] リンクチェック
class CheckLink
  # リンクチェック
  def check_link
    begin
      # Response チェック
      res = Net::HTTP.get_response(URI.parse(URL))
      return unless res.code == "200"

      # HTML 読込 ( a タグのみ取得・配列化 )
      as = Hpricot(OpenURI::open_uri(URL).read).search("a")

      # 各 a タグについて処理
      as.each do |a|
        # href 取得
        href = a.attributes['href']
        # クエリストリングならスキップ
        next if href.include?("?")
        # mailto ならスキップ
        next if href =~ /^mailto/

        # URL ( フルパス ) 設定
        if href =~ /^http/
          url_f = href
        else
          url_f = URI.join(URL, encode_ja(href)).to_s
        end

        # レスポンスチェック
        begin
          res = fetch(url_f)
          puts "[#{res.code}] #{url_f}" unless res.code == "200"
        rescue => e
          # その他のレスポンス（例外発生）時
          puts "[XXX] #{url_f}\n\t#{e}"
        end
      end
    rescue => e
      # その他の例外発生時
      STDERR.puts "[ERROR][#{self.class.name}.check_link] #{e}"
      exit 1
    end
  end

private

  # Fetch 処理
  def fetch(url, limit = 10)
    # HTTP リダイレクトが深すぎる場合は例外を発生させる
    raise ArgumentError, 'HTTP Redirect is too deep!' if limit == 0

    # 環境変数 HTTP_PROXY に設定されていれば Proxy 経由接続とみなす
    # ( Proxy 非考慮なら以下2行はコメントアウト )
    proxy_host, proxy_port = (ENV["HTTP_PROXY"] || '').sub(/http:\/\//, '').split(':')
    proxy = Net::HTTP::Proxy(proxy_host, proxy_port)

    # HTTP レスポンスのチェック
    #uri = URI.parse(url)                               # <= 日本語 URL 非対応
    #http = Net::HTTP.new(uri.host, uri.port)           # <= 日本語 URL 非対応 ( Proxy 非考慮 )
    #http = proxy.new(uri.host, uri.port)               # <= 日本語 URL 非対応 ( Proxy 考慮 )
    uri = Addressable::URI.parse(url)                   # <= 日本語 URL 対応
    #http = Net::HTTP.new(uri.host, uri.inferred_port)  # <= 日本語 URL 対応 ( Proxy 非考慮 )
    http = proxy.new(uri.host, uri.inferred_port)       # <= 日本語 URL 対応 ( Proxy 考慮 )
    http.open_timeout = 10
    http.read_timeout = 20
    if uri.scheme == "https"
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    res = http.request(Net::HTTP::Get.new(uri.path))

    # レスポンス判定
    case res
    when Net::HTTPSuccess      # 2xx はそのまま
      res
    when Net::HTTPRedirection  # 3xx は再度 Fetch
      fetch(URI.join("#{uri.scheme}://#{uri.host}:#{uri.port}", encode_ja(res['location'])).to_s, limit - 1)
    else                       # その他はそのまま
      res
    end
  end

  # 日本語のみ URL エンコード
  def encode_ja(url)
    ret = ""
    url.split(//).each do |c|
      if  "/[-_.!~*'()a-zA-Z0-9;\/\?:@&=+$,%#]/" =~ c
        ret.concat(c)
      else
        ret.concat(CGI.escape(c))
      end
    end
    return ret
  end
end

puts "CHECK [ #{URL} ]"
CheckLink.new.check_link