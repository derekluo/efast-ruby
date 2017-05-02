# coding: utf-8
module EFast
  # Goldpay result
  class Result < ::Hash
    def self.[](result)
      hash = self.new

      require 'json'
      hash.merge! JSON.parse(result).symbolize_keys

    end

    def success?
      self[:status] == '1'
    end
  end
end
