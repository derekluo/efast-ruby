require 'efast/result'
require 'efast/sign'
require 'efast/service'
require 'efast/utils'

#
module EFast
  class << self
    attr_accessor :kh_id, :format, :key, :v, :sign_method, :gateway_url

    def extra_rest_client_options=(options)
      @rest_client_options = options
    end

    def extra_rest_client_options
      @rest_client_options || {}
    end
  end
end
