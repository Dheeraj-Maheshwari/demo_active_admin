Rails.configuration.stripe = {
     :publishable_key => 'pk_test_LYuucWicrc6BPNFHgXbIAUeS00EmsgUNiM',
     :secret_key      => 'sk_test_ikkb3LwvOvrlPYlwzLBw4Ocs00eRtYbDRZ'
    }
    Stripe.api_key = Rails.configuration.stripe[:secret_key]
