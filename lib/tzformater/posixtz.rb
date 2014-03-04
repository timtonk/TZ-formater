module TZFormater
  class PosixTZ < TZFormater::Common::Timezone
    @key = :posix

    def initialize(*args)
      @key = :posix
      super
    end
  end
end