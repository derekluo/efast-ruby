# coding: utf-8
require 'rest_client'
require 'active_support/core_ext/hash/conversions'

module EFast
  # Goldpay services
  module Service

    def self.get(method, params)
      http(:get, method, params)
    end

    def self.post(method, params)
      http(:post, method, params)
    end

    def self.http(http_method, method, params)
      params = {
        method: method,
        format: EFast.format,
        key: EFast.key,
        v: EFast.v,
        sign_method: EFast.sign_method,
        timestamp: Time.now.strftime('%Y-%m-%d %H:%M:%S')
      }.merge(params)

      r = invoke_remote(http_method, gateway_url, sign_and_make_payload(params))

      yield r if block_given?

      r
    end

    def self.sign_and_make_payload(params)
      sign = EFast::Sign.generate(params)

      params = {
        sign: sign
      }.merge(params)

      EFast::Utils.to_sorted_json(params)
    end

    private

    def self.check_required_options(options, names)
      names.each do |name|
        warn("EFast Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end

    def self.gateway_url
      EFast.gateway_url || 'http://121.199.164.211/efast365_test/webefast/web/?app_act=openapi/router'
    end

    def self.invoke_remote(http_method, url, payload, extra_rest_client_options = {})
      params =  {
        method: http_method,
        url: url,
        payload: payload,
        headers: { content_type: 'application/json' }
      }.merge(EFast.extra_rest_client_options).merge(extra_rest_client_options)

      puts "payload: #{payload}" if ENV['DEBUG']
      puts "params: #{params}" if ENV['DEBUG']

      r = RestClient::Request.execute(params)

      EFast::Result[r] if r
    end
  end
end
