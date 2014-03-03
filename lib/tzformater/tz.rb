module TZFormater
  class Timezone
    @@storage = TZFormater::PstoreAdapter.new(TZFormater::FILENAME)
    @@key = :stub

    def self.all
      @@storage.get_all(@@key).map{|tz| self.new(tz) }
    end

    def initialize(tz)
      @tz = tz
      @info = @@storage.get_by(@@key, tz)
      raise ArgumentError.new("Unknown #{@@key.to_s} timezone") if @info.nil?
    end

    def name
      @tz #@info[@@key]
    end

    [:posix, :olson, :win, :win_reg].each do |type|
      define_method(type.to_s) do
        @info[type]
      end
    end
  end
end
