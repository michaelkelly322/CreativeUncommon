require 'paypal-sdk-adaptivepayments'
PayPal::SDK.configure(
  :mode      => "sandbox",  # Set "live" for production
  :app_id    => "APP-80W284485P519543T",
  :username  => "michaelkelly322-facilitator_api1.gmail.com",
  :password  => "1394740509",
  :signature => "AJcd4zryQhQ2ZgcZLiVoqM93-q0wA2dcbJdAmqurm0ecK0o7QXYV-dxB" )

@api = PayPal::SDK::AdaptivePayments.new

# Build request object
@pay = @api.build_pay({
  :actionType => "PAY",
  :cancelUrl => "http://localhost:3000/samples/adaptive_payments/pay",
  :currencyCode => "USD",
  :feesPayer => "SENDER",
  :ipnNotificationUrl => "http://localhost:3000/samples/adaptive_payments/ipn_notify",
  :receiverList => {
    :receiver => [{
      :amount => 1.0,
      :email => "test-author@gmail.com" }] },
  :returnUrl => "http://localhost:3000/samples/adaptive_payments/pay" })

# Make API call & get response
@response = @api.pay(@pay)

# Access response
if @response.success?
  @response.payKey
  @api.payment_url(@response)  # Url to complete payment
else
  @response.error[0].message
end