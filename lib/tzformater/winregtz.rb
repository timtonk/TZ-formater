module TZFormater
  class WinRegTZ < TZFormater::Common::Timezone
    @key = :win_reg

    def initialize(*args)
      @key = :win_reg
      super
    end
  end
end