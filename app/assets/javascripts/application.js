// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require cocoon
/*global $*/

document.addEventListener("turbolinks:load", function() {
  // フォームの追加・削除ボタン
  $('.add_fields').on("click", function () {
    if ($('.nested-fields').length == 5) {
      $('.add_fields').hide();
    }
    $('.remove_fields').on("click", function () {
      if ($('.nested-fields').length < 7 ) {
        $('.add_fields').show();
      }
    });
  });
  $(function() {
    $('.top').slick({
        autoplay: true,
        autoplaySpeed: 2500,
        slidesToShow: 3,
        centerMode: true,
        centerPadding: '80px',
        responsive: [
      {
        breakpoint: 1920,
        settings: {
          arrows: false,
          centerMode: true,
          centerPadding: '40px',
          slidesToShow: 3
        }
      },
      {
        breakpoint: 1200,
        settings: {
          arrows: false,
          centerMode: true,
          centerPadding: '20px',
          slidesToShow: 2
        }
      },
      {
        breakpoint: 768,
        settings: {
          arrows: false,
          centerMode: true,
          centerPadding: '40px',
          slidesToShow: 1
        }
      }
    ]
    });
  })
});

// console.log(('.nested-fields').length)