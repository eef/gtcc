$(document).ready(function() {
  hide_flash();
  slider("pp", 300, 2000, 300);
  slider("pow", 300, 2000, 300);
  slider("we", 300, 2000, 300);
  tooltips();
  tabs();
  generate_results();
  name_autocomplete();
  league_register();
});

function hide_flash() {
  if($('#flash').length > 0) {
    setTimeout("$('#flash').slideUp('fast')", 5000);
  }
}

function league_register() {
  $("#submit-entry").click(function(){
    show_loading("Registering...", "#loading-holder");
    var league_id = $(this).data("league-id");
    var lc_id = $("#league_car_id option:selected").val();
    $.ajax({
      type: 'GET',
      dataType: "html",
      url: "/league/enter/" + league_id + "/" + lc_id,
      success: function(data) {
  			$("#response").html(data);
      }
    });
    return false;
  })
}

function tabs() {
  $( "#tabs" ).tabs();
}

function generate_results() {
  $("#gen_results").click(function(){
    show_loading("Generating results...", "#results");
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

function car_name_autocomplete() {
  $(".autocomplete").each(function(){
    $(this).autocomplete("/find_car").result(function(){
      alert($(this).val());
    }).flushCache();
  });
}

function name_autocomplete() {
  $.widget( "custom.catcomplete", $.ui.autocomplete, {
		_renderMenu: function( ul, items ) {
			var self = this,
				currentCategory = "";
			$.each( items, function( index, item ) {
				if ( item.category != currentCategory ) {
					ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
					currentCategory = item.category;
				}
				self._renderItem( ul, item );
			});
		}
	});
  $(".autocomplete").catcomplete({
    source:"/find_car"
  });
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