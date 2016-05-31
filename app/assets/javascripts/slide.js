  $(function(){
    $('.bgslideshow img:gt(0)').hide();
    setInterval(function() {
      $('.bgslideshow :first-child').fadeOut(5000)  
        .next('img').fadeIn(5000)  
      .end().appendTo('.bgslideshow');  
    }, 15000);
  });