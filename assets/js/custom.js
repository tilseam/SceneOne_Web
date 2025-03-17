// Custom Scripts for Array Template //

jQuery(function ($) {
  "use strict";

  // get the value of the bottom of the #main element by adding the offset of that element plus its height, set it as a variable
  var mainbottom = $('#main').offset().top;

  // on scroll,
  $(window).on('scroll', function () {

    // we round here to reduce a little workload
    stop = Math.round($(window).scrollTop());
    if (stop > mainbottom) {
      $('.navbar').addClass('past-main');
      $('.navbar').addClass('effect-main')
    } else {
      $('.navbar').removeClass('past-main');
    }

  });


  // Collapse navbar on click

  $(document).on('click.nav', '.navbar-collapse.in', function (e) {
    if ($(e.target).is('a')) {
      $(this).removeClass('in').addClass('collapse');
    }
  });


  /*-----------------------------------
  ----------- Scroll To Top -----------
  ------------------------------------*/

  $(window).on('scroll', function () {
    if ($(this).scrollTop() > 1000) {
      $('#back-top').fadeIn();
    } else {
      $('#back-top').fadeOut();
    }
  });
  // scroll body to 0px on click
  $('#back-top').on('click', function () {
    $('#back-top').tooltip('hide');
    $('body,html').animate({
      scrollTop: 0
    }, 1500);
    return false;
  });


  /*-------- Owl Carousel ---------- */

  $(".review-cards").owlCarousel({
    slideSpeed: 200,
    items: 1,
    singleItem: true,
    autoplay: true,
    autoplayTimeout: 2000,
    autoplayHoverPause: true,
    pagination: false,
    touchDrag: true,
    mouseDrag: true,
    smartSpeed: 300,
    loop: true
  });

  // 处理轮播图触摸事件
  $(".review-cards").each(function () {
    let startY = 0;
    let startX = 0;
    let timestamp = 0;
    let isScrolling = false;

    const carousel = $(this)[0];

    carousel.addEventListener('touchstart', function (e) {
      startY = e.touches[0].pageY;
      startX = e.touches[0].pageX;
      timestamp = Date.now();
      isScrolling = undefined;
    }, { passive: true });

    carousel.addEventListener('touchmove', function (e) {
      if (!startX || !startY) {
        return;
      }

      const deltaX = e.touches[0].pageX - startX;
      const deltaY = e.touches[0].pageY - startY;

      // 检测是否是垂直滚动
      if (typeof isScrolling === 'undefined') {
        isScrolling = Math.abs(deltaY) > Math.abs(deltaX);
      }

      // 如果是垂直滚动，不阻止默认行为
      if (isScrolling) {
        return;
      }

      // 只有在水平滑动足够距离时才阻止默认行为
      if (Math.abs(deltaX) > 10 && !isScrolling) {
        e.preventDefault();
      }
    }, { passive: false });

    carousel.addEventListener('touchend', function () {
      startX = 0;
      startY = 0;
      isScrolling = undefined;
    }, { passive: true });
  });


  /* ------ jQuery for Easing min -- */
  (function ($) {
    "use strict"; // Start of use strict

    // Smooth scrolling using jQuery easing
    $('a.js-scroll-trigger[href*="#"]:not([href="#"])').on('click', function () {
      if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
        if (target.length) {
          $('html, body').animate({
            scrollTop: (target.offset().top - 54)
          }, 1000, "easeInOutExpo");
          return false;
        }
      }
    });

    // Closes responsive menu when a scroll trigger link is clicked
    $('.js-scroll-trigger').on('click', function () {
      $('.navbar-collapse').collapse('hide');
    });

    // Activate scrollspy to add active class to navbar items on scroll
    $('body').scrollspy({
      target: '#mainNav',
      offset: 54
    });

  })(jQuery); // End of use strict


  /* --------- Wow Init ------ */

  new WOW().init();


  /* ----- Counter Up ----- */

  $('.counter').counterUp({
    delay: 10,
    time: 1000
  });

  /*----- Preloader ----- */

  $(window).on('load', function () {
    setTimeout(function () {
      $('#loading').fadeOut('slow', function () {
      });
    }, 3000);
  });


  /*----- Subscription Form ----- */

  $(document).ready(function () {
    // jQuery Validation
    $("#chimp-form").validate({
      // if valid, post data via AJAX
      submitHandler: function (form) {
        $.post("assets/php/subscribe.php", { email: $("#chimp-email").val() }, function (data) {
          $('#response').html(data);
        });
      },
      // all fields are required
      rules: {
        email: {
          required: true,
          email: true
        }
      }
    });
  });

});

