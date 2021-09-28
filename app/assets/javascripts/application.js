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
//= require jquery.raty.js
//= require_tree .
//= require cocoon
/*global $*/

document.addEventListener("turbolinks:load", function() {
  // 材料フォームの追加・削除ボタン
  $('.add_ingredient').on("click", function () {
    if ($('.ingredient_fields').length == 2) {
      $('.add_ingredient').hide();
    }
    $('.remove_ingredient').on("click", function () {
      if ($('.ingredient_fields').length < 4 ) {
        $('.add_ingredient').show();
      }
    });
  });
   // 使い方フォームの追加・削除ボタン
  $('.add_guide').on("click", function () {
    if ($('.guide_fields').length == 2) {
      $('.add_guide').hide();
    }
    $('.remove_guide').on("click", function () {
      if ($('.guide_fields').length < 4 ) {
        $('.add_guide').show();
      }
    });
  });
  // slickスライダー
  $(function() {
    $('.top').slick({
        autoplay: true,
        autoplaySpeed: 20000,
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
  });
  // プロフィール編集ページ/プレビュー
  $(function() {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('#prev_img').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
    $("#user_img").change(function(){
      readURL(this);
    });
  });
  // 新規投稿ページ/プレビュー
  $('#post_post_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $('#preview').removeClass('d-none');
        $("#preview").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
  // 投稿編集ページ/プレビュー
  $(function() {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('#img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
    $("#book_img").change(function(){
      readURL(this);
    });
  });
});