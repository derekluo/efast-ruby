require 'efast/result'
require 'efast/sign'
require 'efast/service'
require 'efast/utils'

#
module EFast
  class << self
    attr_accessor :key, :secret, :gateway_url

    attr_writer :format, :v, :sign_method, :kh_id
    attr_writer :extra_rest_client_options

    def format
      @format || 'json'
    end

    def v
      @v || '2.0'
    end

    def sign_method
      @sign_method || 'md5'
    end

    def kh_id
      @kh_id || '888'
    end

    def extra_rest_client_options
      @rest_client_options || {}
    end
  end
end
