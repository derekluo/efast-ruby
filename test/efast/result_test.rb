require 'test_helper'

class EFast::ResultTest < MiniTest::Test
  def test_success_method_with_true
    r = EFast::Result[
      <<-JSON
{
  "resultCode": 1,
  "resultMessage": "The result of the payment is success.",
  "payOrderId":"20150611171533",
  "paymentUrl":"www.xxx.com/pay/xxx.pay",
  "codeUrl":"www.xxx.com/pay/xxx",
  "resultData": "object"
}
        JSON
    ]

    assert_equal r.success?, true
  end

  def test_nonexistent_key
    r = EFast::Result[
        <<-JSON
{
  "resultCode": 1,
  "resultMessage": "The result of the payment is success.",
  "payOrderId":"20150611171533",
  "paymentUrl":"www.xxx.com/pay/xxx.pay",
  "codeUrl":"www.xxx.com/pay/xxx",
  "resultData": "object"
}
        JSON
    ]

    assert_equal r[:resultCode].nil?, false
    assert_equal r[:non_existed].nil?, true
  end

  def test_success_method_with_false
    r = EFast::Result[
        <<-JSON
{}
        JSON
    ]

    assert_equal r.success?, false
  end
end
