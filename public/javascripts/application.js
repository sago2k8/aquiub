(function ($) {
  'use strict' // Start of use strict

    // jQuery for page scrolling feature - requires jQuery Easing plugin
  $('a.page-scroll').bind('click', function (event) {
    var $anchor = $(this)
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top - 50)
    }, 1250, 'easeInOutExpo')
    event.preventDefault()
  })

    // Highlight the top nav as scrolling occurs
  $('body').scrollspy({
    target: '.navbar-fixed-top',
    offset: 100
  })

    // Closes the Responsive Menu on Menu Item Click
  $('.navbar-collapse ul li a').click(function () {
    $('.navbar-toggle:visible').click()
  })

    // Offset for Main Navigation
  $('#mainNav').affix({
    offset: {
      top: 50
    }
  })
})(jQuery) // End of use strict

$(document).ready(function(){
  $(".owl-carousel").owlCarousel({
    margin:5,
    nav:false,
    responsive:{
        0:{
            items:1
        },
        600:{
            items:3
        },
    }
  });
   $(".promotions").owlCarousel({
    margin:5,
    nav:false,
    responsive:{
        0:{
            items:1
        },
        600:{
            items:1
        },
    }
  });

$.ajax({
   url: 'https://api.instagram.com/v1/users/self/media/recent/?access_token=590375326.1677ed0.b72ef6b8d08f437cba2a99c31bad7ee0',
   data: {
      format: 'json'
   },
   error: function() {
      $('#gallery_container').html('<p>An error has occurred</p>');
   },
   dataType: 'jsonp',
   success: function(data) {
      console.log(data.data[0])
      $.each(data.data, function( index, value ) {
        console.log(value)
        $( "#gallery_container" ).append( "<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'><a class='thumbnail fancybox' rel='ligthbox' href="+ value.images.standard_resolution.url+ "><img class='img-responsive' alt='' src="+ value.images.standard_resolution.url+  " /> </a> </div>" );
      });

   },
   type: 'GET'
});

$(".fancybox").fancybox({
        openEffect: "none",
        closeEffect: "none"
    });
});

