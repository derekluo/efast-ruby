require 'test_helper'

class EFast::SignTest < MiniTest::Test
  def setup
    EFast.key = 'demo'
    EFast.secret = 'demo'

    @params = {
      method: 'oms.order.return.list.get',
      timestamp: '2015-07-01 13:06:26',
      page: 1,
      page_size: 10,
      format: 'json',
      key: EFast.key,
      v: '2.0',
      sign_method: 'md5',
      kh_id: '888'
    }

    @sign = 'B25E69F6A669D9C5708B396B65609080'
  end

  def test_generate_sign
    assert_equal @sign, EFast::Sign.generate(@params)
  end

  def test_verify_sign
    assert EFast::Sign.verify?(@params.merge(:sign => @sign))
  end

  def test_verify_sign_when_fails
    assert !EFast::Sign.verify?(@params.merge(:danger => 'danger', :sign => @sign))
  end

  def test_accept_pars_key_to_generate_sign
    @params.merge!(key: 'key')

    assert_equal "F3165562C2388EA343BF09A0FEC36C6C", EFast::Sign.generate(@params)
  end
end
