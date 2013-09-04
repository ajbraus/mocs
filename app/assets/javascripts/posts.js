//jQuery time
var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

$(".next").click(function(){  
  current_fs = $(this).parent().parent();
  next_fs = $(this).parent().parent().next();
  
  //activate next step on progressbar using the index of next_fs
  $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

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

