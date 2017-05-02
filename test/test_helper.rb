require 'active_support/core_ext/hash/conversions'
require 'minitest/autorun'
require 'EFast'
require 'fakeweb'

require 'minitest/byebug' if ENV['DEBUG']

EFast.key = '84f7691d2fa9ead7ba31bcb2c5719480'
EFast.secret = '989bff7b9afe425d6735f906dfc41bbb'
EFast.gateway_url = 'http://openapi.baotayun.com/openapi/webefast/web/?app_act=openapi/router'
