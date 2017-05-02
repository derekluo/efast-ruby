require 'test_helper'

class EFast::SignTest < MiniTest::Test
  def setup
    @params = {
      clientId: '7570',
      orderId: '1400755861',
      payAmount: 1,
      type: 1,
      nonce_str: '960f228109051b9969f76c82bde183ac',
      itemDesc: 'tickets',
      returnUrl: "https://www.example.com/callback"
    }

    @sign = '5C04B8AD74C262AB473218E072A67BD9'
  end

  def test_generate_sign
    assert_equal @sign, Goldpay::Sign.generate(@params)
  end

  def test_verify_sign
    assert Goldpay::Sign.verify?(@params.merge(:sign => @sign))
  end

  def test_verify_sign_when_fails
    assert !Goldpay::Sign.verify?(@params.merge(:danger => 'danger', :sign => @sign))
  end

  def test_accept_pars_key_to_generate_sign
    @params.merge!(key: "key")

    assert_equal "EC0E9CCD637453F4FE821BBD798311B4", Goldpay::Sign.generate(@params)
  end
end
