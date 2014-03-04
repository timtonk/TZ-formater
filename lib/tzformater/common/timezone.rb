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
        if @info[:olson].kind_of? Array
          @info[:olson].map{|tz| TZFormater::OlsonTZ.new(tz) }
        else
          TZFormater::OlsonTZ.new(@info[:olson])
        end
      end

      def win
        return self if @key == :win
        if @info[:win].kind_of? Array
          @info[:win].map{|tz| TZFormater::WinTZ.new(tz)}
        else
          TZFormater::WinTZ.new(@info[:win])
        end
      end

      def win_reg
        return self if @key == :win_reg
        @info[:win_reg].map{|tz| TZFormater::WinRegTZ.new(tz)}
      end

      def offset
        @info[:offset]
      end
    end
  end
end
