//jQuery time
var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

$(".next").click(function(){  
  current_fs = $(this).parent().parent();
  next_fs = $(this).parent().parent().next();
  
  //activate next step on progressbar using the index of next_fs
  $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

  $('body').scrollTop(0);

  current_fs.hide();

  //show the next fieldset
  next_fs.fadeIn();
});

$(".previous").click(function(){
  current_fs = $(this).parent().parent();
  previous_fs = $(this).parent().parent().prev();
  
  //de-activate current step on progressbar
  $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
  
  current_fs.hide();

  //show the previous fieldset
  previous_fs.fadeIn();
});

$(".submit").click(function(){
  return false;
})

$("#progressbar li").click(function(){
  step = $(this).data("step")

  $("#progressbar li").eq(step + 1).removeClass("active");
  $("#progressbar li").eq(step + 2).removeClass("active");
  $("#progressbar li").eq(step + 3).removeClass("active");
  $("#progressbar li").eq(step + 4).removeClass("active");
  $("#progressbar li").eq(step + 5).removeClass("active");

  $(this).addClass("active");

  $('fieldset:visible').hide();
  $('fieldset').eq(step).fadeIn();
});


if (!!$('#post_title').val() && 
    !!$("#post_goal_id option:selected").val().length > 0) 
{
  $("#save").removeClass("disabled");
}

if ($('#post_title').length > 0 && 
    $("#post_goal_id option:selected").val().length > 0 &&
    $("#post_expected_time").val().length > 0 &&
    $("#post_duration").val().length > 0 &&
    $("#post_desc").val().length > 0 &&
    $("#post_price_in_dollars").val().length > 0 &&
    $("#post_info").val().length > 0 &&
    $("#post_baseline").val().length > 0 &&
    $("#post_plan_do").val().length > 0 &&
    $("#post_post_test").val().length > 0 &&
    $("#post_wrap_up").val().length > 0)
    // $("#post_credits").val().length > 0 &&
    // $("#post_begins_on").val().length > 0 &&
    // $("#post_ends_on").val().length > 0 &&
{
  $('#publish').val("Publish!").removeClass("disabled").addClass("btn-gold");
}


$("form").keyup(function(){
  if ($('#post_title').val().length > 0 && 
      $("#post_goal_id option:selected").val().length > 0) 
  {
    $("#save").addClass("btn-success").removeClass("disabled");
    $("#saveTip").remove();
  }

  if ($('#post_title').length > 0 && 
      $("#post_goal_id option:selected").val().length > 0 &&
      $("#post_expected_time").val().length > 0 &&
      $("#post_duration").val().length > 0 &&
      $("#post_desc").val().length > 0 &&
      $("#post_price_in_dollars").val().length > 0 &&
      // $("#post_credits").val().length > 0 &&
      // $("#post_begins_on").val().length > 0 &&
      // $("#post_ends_on").val().length > 0 &&
      $("#post_info").val().length > 0 &&
      $("#post_baseline").val().length > 0 &&
      $("#post_plan_do").val().length > 0 &&
      $("#post_post_test").val().length > 0 &&
      $("#post_wrap_up").val().length > 0)
  {
    $('#publish').val("Publish!").removeClass("disabled").addClass("btn-gold");
  }
});

$(function() {
  $( ".datepicker" ).datepicker({ 
    dateFormat: "dd-mm-yy",
    minDate: new Date()
   });
});
