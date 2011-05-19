$(document).ready(function() {
  hide_flash();
  solar_system_autocomplete();
});

function hide_flash() {
  if($('#flash').length > 0) {
    setTimeout("$('#flash').slideUp('fast')", 5000);
  }
}

function solar_system_autocomplete() {
  $("#starbase_solar_system").autocomplete("/solar_systems").result(function(){
    show_loading("Loading moons...", "#celestial");
    get_celestials();
  }).flushCache();
}

function get_celestials() {
  $.get("/celestials", {
    solar_system_name: $('#starbase_solar_system').val()
  }, function(response){
    $("#celestial").html(response);
  })
}

function show_loading(title, selector) {
  $(selector).html("<div class='loading'><img src='/stylesheets/indicator.gif' /><span class='form-note'>" + title + "</span></div>");
}
