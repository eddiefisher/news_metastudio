//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap/bootstrap
//= require redactor/redactor
//= require_tree .

$(document).ready(function() {
  $(".alert").alert()
  window.setTimeout(function() { $(".alert").alert('close'); }, 2000);
  $('.redactor').redactor()
});
$(document).on('page:load', function () {
  $('.redactor').redactor()
})