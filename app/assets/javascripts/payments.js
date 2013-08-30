// This identifies your website in the createToken call below
Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

var stripeCustomerResponseHandler = function(status, response) {
  var $form = $('#new_commitment');

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message).fadeIn();
    $form.find('button').prop('disabled', false);
  } else {
    // token contains id, last4, and card type
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    // and re-submit
    $form.get(0).submit();
  }
};

var stripeRecipientResponseHandler = function(status, response) {
  console.log(status)
  console.log(response)
  var $form = $('#new_recipient');
  // var type = $('#type').val();

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message).fadeIn();
    $form.find('button').prop('disabled', false);
  } else {
    // token contains id, last4, and card type
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeBankToken" />').val(token));
    //$form.append($('<input type="hidden" name="type" />').val(type));
    // and re-submit
    $form.get(0).submit();
  }
}

jQuery(function($) {
  $('#new_commitment').submit(function(e) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.createToken($form, stripeCustomerResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  });
});

jQuery(function($) {
  $('#new_recipient').submit(function(e) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.bankAccount.createToken({
        name: $("#name").val(),
        country: "US",
        type: $('#type').val(),
        routingNumber: $('#bankRoutingNumber').val(),
        accountNumber: $('#bankAccountNumber').val(),
      }, stripeRecipientResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  });
});