module TZFormater
  class PosixTZ
    @@storage = TZFormater::PstoreAdapter.new(TZFormater::FILENAME)
  end
end