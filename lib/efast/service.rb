# coding: utf-8
require 'rest_client'
require 'active_support/core_ext/hash/conversions'

module EFast
  # Goldpay services
  module Service
    PAY_REQUIRED_FIELDS = %i( orderId clientId payAmount type nonceStr returnUrl )
    PAY_ENDPOINT = 'pay.do'
    def self.pay(params)
      params = {
        clientId: Goldpay.client_id,
        nonceStr: SecureRandom.uuid.tr('-', '')
      }.merge(params)

      check_required_options(params, PAY_REQUIRED_FIELDS)

      r = invoke_remote("#{gateway_url}/tpps/#{PAY_ENDPOINT}", sign_and_make_payload(params))

      yield r if block_given?

      r
    end

    REFUND_REQUIRED_FIELDS = %i( payOrderId clientId refundType refundAmount refundReason )
    REFUND_ENDPOINT = 'refund.do'
    def self.refund(params)
      params = {
        clientId: Goldpay.client_id
      }.merge(params)

      check_required_options(params, REFUND_REQUIRED_FIELDS)

      r = invoke_remote("#{gateway_url}/tpps/#{REFUND_ENDPOINT}", sign_and_make_payload(params))

      yield r if block_given?

      r
    end

    QUERY_REQUIRED_FIELDS = %i( payOrderIds clientId )
    QUERU_ENDPOINT = 'query.do'
    def self.query(params)
      params = {
        clientId: Goldpay.client_id
      }.merge(params)

      check_required_options(params, QUERY_REQUIRED_FIELDS)

      r = invoke_remote("#{gateway_url}/tpps/#{QUERU_ENDPOINT}", sign_and_make_payload(params))

      yield(r) if block_given?

      r
    end

    MERCHANT_PAY_REQUIRED_FIELDS = %i( orderId clientId payAmount type nonceStr email)
    MERCHANT_PAY_ENDPOINT = 'merchantPay.do'

    def self.merchant_pay(params)
      params = {
        clientId: Goldpay.client_id,
        nonceStr: SecureRandom.uuid.tr('-', '')
      }.merge(params)

      check_required_options(params, MERCHANT_PAY_REQUIRED_FIELDS)

      r = invoke_remote("#{gateway_url}/tpps/#{MERCHANT_PAY_ENDPOINT}", sign_and_make_payload(params))

      yield(r) if block_given?

      r
    end

    MASS_TRANSFER_REQUIRED_FIELDS = %i( clientId orderId toUser )
    MASS_TRANSFER_ENDPOINT = 'transferBatch.do'
    def self.mass_transfer(params)
      params = {
        clientId: Goldpay.client_id
      }.merge(params)

      check_required_options(params, MASS_TRANSFER_REQUIRED_FIELDS)

      r = invoke_remote("#{gateway_url}/tpps/#{MASS_TRANSFER_ENDPOINT}", sign_and_make_payload(params))

      yield(r) if block_given?

      r
    end

    def self.sign_and_make_payload(params)
      sign = Goldpay::Sign.generate(params)

      params = {
        sign: sign
      }.merge(params)

      Goldpay::Utils.to_sorted_json(params)
    end

    private

    def self.check_required_options(options, names)
      names.each do |name|
        warn("Goldpay Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end

    def self.gateway_url
      Goldpay.gateway_url || 'https://tpps.goldpay.com'
    end

    def self.invoke_remote(url, payload, extra_rest_client_options = {})
      params =  {
        method: :post,
        url: url,
        payload: payload,
        headers: { content_type: 'application/json' }
      }.merge(Goldpay.extra_rest_client_options).merge(extra_rest_client_options)

      puts "payload: #{payload}" if ENV['DEBUG']
      puts "params: #{params}" if ENV['DEBUG']

      r = RestClient::Request.execute(params)

      Goldpay::Result[r] if r
    end
  end
end
