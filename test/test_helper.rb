require 'active_support/core_ext/hash/conversions'
require 'minitest/autorun'
require 'goldpay'
require 'fakeweb'

require 'minitest/byebug' if ENV['DEBUG']

Goldpay.client_id = '9d821413c68c40c884ee847056af3127'
Goldpay.key = 'cbaff31cecca0ef8b64dc04c0dc7ea9b'
Goldpay.gateway_url = 'https://tpps888.goldpay.com'
