module TZFormater
  class PosixTZ
    @@storage = TZFormater::PstoreAdapter.new(TZFormater::FILENAME)

    def initialize(posix_timezone)
      @tz = posix_timezone
    end
  end
end