if Rails.env.production?
  Stripe.api_key = ENV['STRIPE_PRODUCTION_SECRET_KEY']
  STRIPE_PUBLIC_KEY = ENV['STRIPE_PRODUCTION_PUBLIC_KEY']
else
  Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']
  STRIPE_PUBLIC_KEY = ENV['STRIPE_TEST_PUBLIC_KEY']
end  