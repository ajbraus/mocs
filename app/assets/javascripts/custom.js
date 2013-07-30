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
  id = "#" + step
  $(id).removeClass("disabled strike-through").addClass("btn-primary")
  $('a').click(function() { 
    if ($(this).children('div').hasClass("disabled")) 
    {
    return false; 
    }
  });

  $("tr[data-link]").click(function() {
    window.location = $(this).data("link")
  })


  // var a = [$('#trendingTags').data("tags")];
  // var colors = ["label-warning", "label-info", "label-success", "label-important", "label-default", "label-inverse"];
  // a.forEach(function(entry) {
  //   var color = colors[Math.floor(Math.random()*colors.length)];
  //   var style = "label " + color
  //   $('#trendingTags').prepend("<span class='" + style + "''>" + entry + "</span>")
  // });

  // $('#closeJumbotron').click(function(){
  //   $('#overview').slideUp();
  // });

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

  $('.alert').delay(2000).fadeOut();
  $('.hover-edit').hover(function(){
    $(this).find('.edit').fadeToggle('fast');
  })
  // $('.label').click(function(){
  //  $(this).appendTo('#searchTags');
  // });

  // $('#clearBtn').click(function(){
  //   $('#searchTags').children().prependTo('#topicMenu');
  // });

  // var index;

  // for (index = 0; index < a.length; ++index) {
  //   $('#topicMenu').append("<span class='label label-warning'>" + index + "</span>")
  // }
});