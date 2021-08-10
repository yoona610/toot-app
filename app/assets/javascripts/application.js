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

document.addEventListener("turbolinks:load", function() {
  $('.add_fields').on("click", function () {
    if ($('.nested-fields').length == 5) {
      $('.add_fields').hide();
    }
    $('.remove_fields').on("click", function () {
        console.log(('.nested-fields').length)

      if ($('.nested-fields').length < 7 ) {
        $('.add_fields').show();
      }
    });
  });
})
// 追加
// var minCount = 1;
// var maxCount = 6;

// $(function(){
// $('.add_fields').on('click', function(){
//   var inputCount = $('#ingredients .unit').length;
//   if (inputCount < maxCount){
//     var element = $('#ingredients .unit:last-child').clone(true);
//     var inputList = element[0].querySelectorAll('input[type="text"]');
//     for (var i = 0; i < inputList.length; i++) {
//       inputList[i].value = "";
//     }
//     $('#ingredients').parent().append(element);
//   }
// });

// 削除
// $('.remove_fields').on('click', function(){
//   var inputCount = $('#ingredients').length;
//   if (inputCount > minCount){
//     $(this).parents('.unit').remove();
//   }
// });
// });