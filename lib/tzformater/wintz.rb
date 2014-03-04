module TZFormater
  class WinTZ < TZFormater::Common::Timezone
    @key = :win

    def initialize(*args)
      @key = :win
      super
    end
  end
end