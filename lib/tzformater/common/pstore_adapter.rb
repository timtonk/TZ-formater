require 'pstore'

module TZFormater
  module Common
    class PstoreAdapter
      READ_ONLY = true

      def initialize(filename)
        raise PStore::Error.new("Cannot find such file -- " << filename) unless File.exist?(filename)
        @file = PStore.new(filename)
      end

      def get_by(type, timezone)
        get_all(type).fetch(timezone, nil)
      end

      def get_all_keys(type)
        get_all(type).keys
      end

      def get_all(type)
        list = {}
        @file.transaction(READ_ONLY) do
          list = @file.fetch(type, {})
        end
        list
      end
    end
  end
end