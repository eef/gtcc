$(document).ready(function() {
  hide_flash();
  solar_system_autocomplete();
  slider("pp", 300, 2000, 300);
  slider("pow", 300, 2000, 300);
  slider("we", 300, 2000, 300);
  tooltips();
  tabs();
  generate_results();
});

function hide_flash() {
  if($('#flash').length > 0) {
    setTimeout("$('#flash').slideUp('fast')", 5000);
  }
}

function tabs() {
  $( "#tabs" ).tabs();
}

function generate_results() {
  $("#gen_results").click(function(){
    var race_id = $(this).data("race-id");
    $.ajax({
      type: 'GET',
      dataType: "html",
      url: "/race/gen_results/" + race_id,
      success: function(data){
  			$("#results").html(data);
      }
    });
    return false;
  })
}

function tooltips() {
    $('.has-tip').qtip({
    style: {
      name: 'dark',
      tip: true,
      'font-size': 12,
      width: {
        max: 400
      },
      border: {
        width: 2,
        radius: 4
      }
    },
    position: {
      corner: {
        target: 'leftMiddle',
        tooltip: 'rightMiddle'
      }
    }
  })
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

function slider(div_id, min, max, value) {
  $("#" + div_id + "-slider").slider({
    range: "min",
		value: value,
		min: min,
		max: max,
		slide: function( event, ui ) {
		  $("#" + div_id + "-input").val(ui.value);
		}
	});
	$("#" + div_id + "-input").keyup(function(){
	  var value = $(this).val();
	  if(value > 0 && value < min) {
	    $("#" + div_id + "-slider").slider("value", min);
	  } else if(value >= min && value < max) {
	    $("#" + div_id + "-slider").slider("value", value);
	  }
	})
  if($("#" + div_id + "-input").val() > 0) {
    $("#" + div_id + "-slider").slider("value", $("#" + div_id + "-input").val());
  } else {
    $("#" + div_id + "-slider").slider("value", min);
  }
}