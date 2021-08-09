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

$(document).on('turbolinks:load', function() {
  $(function() {
  // limits the number of ingredients
  $('#ingredients').on('cocoon:after-insert', function() {
    check_to_hide_or_show_add_link();
  });

  $('#ingredients').on('cocoon:after-remove', function() {
    check_to_hide_or_show_add_link();
  });

  check_to_hide_or_show_add_link();
s
  function check_to_hide_or_show_add_link() {
    if ($('#ingredients .nested-fields:visible').length == 5) {
      $('#hide-button').hide();
    } else {
      $('#hide-button').show();
    }
  }
  })
});