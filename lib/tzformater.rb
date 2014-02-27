module TZFormater
  FILENAME = File.expand_path('tzformater/data/formats.pstore', File.dirname(__FILE__))
end

require 'tzformater/pstore_adapter'
require 'tzformater/posixtz'