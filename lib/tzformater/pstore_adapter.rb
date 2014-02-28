require 'pstore'

module TZFormater
  class PstoreAdapter
    READ_ONLY = true

    def initialize(filename)
      @file = PStore.new(filename)
    end

    def get_by(type, timezone)
      get_type(type).fetch(timezone, nil)
    end

    def get_all(type)
      get_type(type).keys
    end

    private
      def get_type(type)
        list = {}
        @file.transaction(READ_ONLY) do
          list = @file.fetch(type, {})
        end
        list
      end
  end
end