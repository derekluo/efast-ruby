# coding: utf-8
require 'json'

module EFast
  module Utils
    def self.to_sorted_json_without_empty_value(params)
      params = params.select { |_, value| value != '' && !value.nil? }

      to_sorted_json(params)
    end

    def self.to_sorted_json(hash)
      hash.symbolize_keys.sort.map do |k, v|
        "#{k}#{v}"
      end.join('')
    end
  end
end
