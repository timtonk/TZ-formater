module TZFormater
  class OlsonTZ < TZFormater::Common::Timezone
    @key = :olson

    def initialize(*args)
      @key = :olson
      super
    end
  end
end