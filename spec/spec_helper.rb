require 'active_support/core_ext/hash/conversions'
require 'efast'
require 'fakeweb'
require 'pry-byebug'

# EFast.kh_id = '888' #

EFast.format = 'json'
EFast.key = '84f7691d2fa9ead7ba31bcb2c5719480'
EFast.v = '2.0'
EFast.sign_method = 'md5'

EFast.gateway_url = 'http://openapi.baotayun.com/openapi/webefast/web/?app_act=openapi/router'
