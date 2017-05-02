require 'spec_helper'

RSpec.describe Goldpay::Result do

  it "should success? with true use resultCode with 1" do
    r = Goldpay::Result[
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
    expect(r.success?).to be_truthy
  end

  it "should not success? with true use resultCode with not 1" do
    r = Goldpay::Result[
      <<-JSON
{
  "resultCode": 2,
  "resultMessage": "The result of the payment is success.",
  "payOrderId":"20150611171533",
  "paymentUrl":"www.xxx.com/pay/xxx.pay",
  "codeUrl":"www.xxx.com/pay/xxx",
  "resultData": "object"
}
        JSON
    ]
    expect(r.success?).not_to be_truthy
  end

  it "like a hash can judge nonexisted key by result[key]" do
    r = Goldpay::Result[
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
    expect(r[:resultCode].nil?).to eq false
    expect(r[:non_existed].nil?).to eq true
  end

  it "should not success with empty result json" do
    r = Goldpay::Result[
        <<-JSON
{}
        JSON
    ]
    expect(r.success?).not_to be_truthy
  end
end
