module TZFormater
  module Common
    class Timezone
      attr_reader :name

      @@storage = TZFormater::Common::PstoreAdapter.new(TZFormater::FILENAME)

      def self.all
        @@storage.get_all(@key).map{|key, value| self.new(key, value) }
      end

      def initialize(tz, info = nil)
        @name = tz
        @info = info || @@storage.get_by(@key, @name)
        raise ArgumentError.new("Unknown #{@key} timezone") if @info.nil?
      end

      def posix
        return self if @key == :posix
        TZFormater::PosixTZ.new(@info[:posix])
      end

      def olson
        return self if @key == :olson
        process_tzs(@info[:olson]) {|tz| TZFormater::OlsonTZ.new(tz) }
      end

      def win
        return self if @key == :win
        process_tzs(@info[:win]) {|tz| TZFormater::WinTZ.new(tz) }
      end

      def win_reg
        return self if @key == :win_reg
        @info[:win_reg].map{|tz| TZFormater::WinRegTZ.new(tz)}
      end

      def offset
        @info[:offset]
      end

      private
        def process_tzs(tz_list)
          if tz_list.kind_of? Array
            tz_list.map{|tz| yield(tz) }
          else
            yield(tz_list)
          end
        end
    end
  end
end
