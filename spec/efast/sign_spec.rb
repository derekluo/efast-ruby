require 'spec_helper'

RSpec.describe Goldpay::Sign do

  let(:params){
    {
      clientId: '7570',
      orderId: '1400755861',
      payAmount: 1,
      type: 1,
      nonce_str: '960f228109051b9969f76c82bde183ac',
      itemDesc: 'tickets',
      returnUrl: "https://www.example.com/callback"
    }
  }

  let(:sign){'5C04B8AD74C262AB473218E072A67BD9'}

  it "should generate correct sign" do
    expect(sign).to eq Goldpay::Sign.generate(params)
  end

  it "should verify correct sign" do
    expect(Goldpay::Sign.verify?(params.merge(:sign => sign))).to be_truthy
  end

  it "should verify wrong sign" do
    expect(Goldpay::Sign.verify?(params.merge(:danger => 'danger',:sign => sign))).to be_falsy
  end

  it "should accept pars key to generate sign" do
    expect(Goldpay::Sign.generate(params.merge(key: "key"))).to eq "EC0E9CCD637453F4FE821BBD798311B4"
  end

end
