# coding: utf-8
require 'digest/md5'

module EFast

  module Sign
    def self.generate(params)
      json_string = EFast::Utils.to_sorted_json_without_empty_value(params)

      puts "json_string: #{json_string}" if ENV['DEBUG']

      string_sign_temp = "#{EFast.secret}#{json_string}#{EFast.secret}"
      puts "string_sign_temp: #{string_sign_temp}" if ENV['DEBUG']

      Digest::MD5.hexdigest(string_sign_temp).upcase
    end

    def self.verify?(params_with_sign)
      params = params_with_sign.dup
      sign = params.delete('sign') || params.delete(:sign)

      generate(params) == sign
    end
  end
end
