module Jekyll::Minibundle
  module Hashes
    class << self
      def dig(obj, *keys)
        value = obj
        keys.each do |key|
          return nil unless value
          value = value[key]
        end
        value
      end

      def pick(hash, *keys)
        keys.each_with_object({}) do |key, acc|
          acc[key] = hash.fetch(key)
        end
      end
    end
  end
end
