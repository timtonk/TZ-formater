require 'pstore'

module TZFormater
  class PstoreAdapter
    READ_ONLY = true

    def initialize(filename)
      @file = PStore.new(filename)
    end
  end
end