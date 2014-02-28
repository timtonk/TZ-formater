module TZFormater
  class PosixTZ
    @@storage = TZFormater::PstoreAdapter.new(TZFormater::FILENAME)

    def self.all
      @@storage.get_all(:posix)
    end

    def initialize(tz = 'Etc/GMT')
      @info = @@storage.get_by(:posix, tz)
      raise ArgumentError.new('Unknown POSIX timezone') if @info.nil?
    end

    def to_olson
      @info[:olson]
    end

    def to_win
      @info[:win]
    end

    def to_win_reg
      @info[:win_reg]
    end
  end
end