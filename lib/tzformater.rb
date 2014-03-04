module TZFormater
  FILENAME = File.expand_path('tzformater/data/formats.pstore', File.dirname(__FILE__))
end

require 'tzformater/common/pstore_adapter'
require 'tzformater/common/timezone'
require 'tzformater/posixtz'
require 'tzformater/wintz'
require 'tzformater/olsontz'
require 'tzformater/winregtz'

