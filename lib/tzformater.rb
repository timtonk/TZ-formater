module TZFormater
  FILENAME = File.expand_path('tzformater/data/formats.pstore', File.dirname(__FILE__))
end

require 'require_all'
require_rel 'tzformater'
