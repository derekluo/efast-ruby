# EFast

A simple efast ruby gem, without unnecessary magic or wrapper.

## Installation

Add this line to your Gemfile:

```ruby
gem 'efast-ruby'
```
And then execute:

```sh
$ bundle
```

## Usage

### Config

Create `config/initializers/efast.rb` and put following configurations into it.

```ruby
# required

EFast.key = 'YOUR_KEY'

# optional - configurations for RestClient timeout, etc.
EFast.extra_rest_client_options = {timeout: 2, open_timeout: 3}
```

### APIs

**Check official document for detailed request params and return fields**

#### Notify Process

A simple example of processing notify.

```ruby
# config/routes.rb
post "notify" => "orders#notify"

# app/controllers/orders_controller.rb

# example: {"retCode":1,"status":"complete","attach":"","payOrderId":"201511304A001P000175","backUrl":"http://52.74.138.97/videoVote/GpPayAction/payCallback.action"}

def notify
  result = Goldpay::Result[request.body.read]

if result[:retCode] == 1
    if result[:status] == "created"
      # find your order and process the post-paid logic.

      render :xml => {return_code: "SUCCESS"}.to_xml(root: 'xml', dasherize: false)

    else # "complete", etc

    # do something else.

    end
  else
    render :xml => {return_code: "FAIL", return_msg: "签名失败"}.to_xml(root: 'xml', dasherize: false)
  end
end
```

### Integretion with QRCode(二维码)

Goldpay payment integrating with QRCode is a recommended process flow which will bring users comfortable experience. It is recommended to generate QRCode using `rqrcode` and `rqrcode_png`.

**Example Code** (please make sure that `public/uploads/qrcode` was created):

```ruby
r = Goldpay::Service.pay params
qrcode_png = RQRCode::QRCode.new( r["code_url"], :size => 5, :level => :h ).to_img.resize(200, 200).save("public/uploads/qrcode/#{@order.id.to_s}_#{Time.now.to_i.to_s}.png")
@qrcode_url = "/uploads/qrcode/#{@order.id.to_s}_#{Time.now.to_i.to_s}.png"
```
