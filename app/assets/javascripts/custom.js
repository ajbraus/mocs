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