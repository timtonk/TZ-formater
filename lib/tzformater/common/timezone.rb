module TZFormater
  module Common
    class Timezone
      attr_reader :name

      methods = {
        posix:    :PosixTZ,
        olson:    :OlsonTZ,
        win:      :WinTZ,
        win_reg:  :WinRegTZ
      }

      @@storage = TZFormater::Common::PstoreAdapter.new(TZFormater::FILENAME)

      def self.all
        @@storage.get_all(@key).map{|key, value| self.new(key, value) }
      end

      def initialize(tz, info = nil)
        @name = tz
        @info = info || @@storage.get_by(@key, @name)
        raise ArgumentError.new("Unknown #{@key} timezone") if @info.nil?
      end

      methods.each do |name, klass|
        define_method(name) do
          return self if @key == name
          process_tzs(@info[name]) {|tz| TZFormater.const_get(klass).new(tz) }
        end
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
