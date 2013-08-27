String.prototype.supplant = function (o) {
    return this.replace(/{([^{}]*)}/g,
        function (a, b) {
            var r = o[b];
            return typeof r === 'string' || typeof r === 'number' ? r : a;
        }
    );
};

$(document).ready(function() {
  step = parseInt($('#progress').text()) + 1
  el = "." + step
  $(el).removeClass("disabled strike-through").addClass("btn-primary")
  $('a').click(function() { 
    if ($(this).children('div').hasClass("disabled")) 
    {
    return false; 
    }
  });

  $('li').each(function(){
    if ($(this).hasClass("disabled")) 
    {
      $(this).first('a').click(function(){
        return false;
      });
    }
  })

  $(".disabled").click(function(){
    if ($(this).hasClass("disabled")){
      return false;
    }
  });


  if ($('#post_title').val() > 0 && 
      $("#post_goal_id option:selected").val().length > 0) 
  {
    $("#save").removeClass("disabled");
  }

  if ($('#post_title').length > 0 && 
      $("#post_goal_id option:selected").val().length > 0 &&
      $("#post_expected_time").val().length > 0 &&
      $("#post_duration").val().length > 0 &&
      $("#post_desc").val().length > 0 &&
      $("#post_credits").val().length > 0 &&
      $("#post_price_in_dollars").val().length > 0 &&
      $("#post_begins_on").val().length > 0 &&
      $("#post_ends_on").val().length > 0 &&
      $("#post_info").val().length > 0 &&
      $("#post_baseline").val().length > 0 &&
      $("#post_plan_do").val().length > 0 &&
      $("#post_post_test").val().length > 0 &&
      $("#post_wrap_up").val().length > 0)
  {
    $('#publish').removeClass("disabled");
  }


  $("form").keyup(function(){
    if ($('#post_title').val().length > 0 && 
        $("#post_goal_id option:selected").val().length > 0) 
    {
      $("#save").removeClass("disabled");
    }
    if ($('#post_title').length > 0 && 
        $("#post_goal_id option:selected").val().length > 0 &&
        $("#post_expected_time").val().length > 0 &&
        $("#post_duration").val().length > 0 &&
        $("#post_desc").val().length > 0 &&
        $("#post_credits").val().length > 0 &&
        $("#post_price_in_dollars").val().length > 0 &&
        $("#post_begins_on").val().length > 0 &&
        $("#post_ends_on").val().length > 0 &&
        $("#post_info").val().length > 0 &&
        $("#post_baseline").val().length > 0 &&
        $("#post_plan_do").val().length > 0 &&
        $("#post_post_test").val().length > 0 &&
        $("#post_wrap_up").val().length > 0)
    {
      $('#publish').removeClass("disabled");
    }
  });

  $(function() {
    $( ".datepicker" ).datepicker({ 
      dateFormat: "dd-mm-yy",
      minDate: new Date()
     });
  });

  $("tr[data-link]").click(function() {
    window.location = $(this).data("link")
  })

  $('#organization').autocomplete({
    source: $('#organization').data('autocomplete-source')
  });
  
  $('textarea.rich-text').wysihtml5({ 
    "font-styles": false,
    "image": false,
    "color": true
  })

  incomplete = $('form :input').filter(function() {
                    return $(this).val() == '';
                  });
  if(incomplete.length > 0){}
  else {
    $('#publish').removeClass("disabled")  
  }

  $('input').keypress(function(){
    incomplete = $('form :input').filter(function() {
                        return $(this).val() == '';
                      });
    if(incomplete.length > 0){}
    else {
      $('#publish').removeClass("disabled")  
    }
  })
  

  $('#register').click(function(){
    $('#overview').slideUp();
  });

  $('.alert').delay(3000).fadeOut();
  $('.hover-edit').hover(function(){
    $(this).find('.edit').fadeToggle('fast');
  })


  // VALIDATIONS
  $('#new_registration').validate();
});