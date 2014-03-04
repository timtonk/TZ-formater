module TZFormater
  module Common
    class Timezone
      attr_reader :name

      @@storage = TZFormater::Common::PstoreAdapter.new(TZFormater::FILENAME)

      def self.all
        @@storage.get_all(@key).map{|tz| self.new(tz) }
      end

      def initialize(tz)
        @name = tz
        @info = @@storage.get_by(@key, @name)
        raise ArgumentError.new("Unknown #{@key} timezone") if @info.nil?
      end

      [:posix, :olson, :win, :win_reg].each do |type|
        define_method(type) do
          type == @key ? self : @info[type]
        end
      end

      def offset
        @info[:offset]
      end
    end
  end
end
