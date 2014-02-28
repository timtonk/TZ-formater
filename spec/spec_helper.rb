require 'simplecov'
require 'coveralls'
require 'require_all'
require_rel 'helpers'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '/spec/'
end

require 'tzformater'

RSpec.configure do |config|
  config.include PstoreHelper, depends: :PstoreHelper

  config.expect_with :rspec do |c|
    c.syntax = :expect # disable the `should` syntax
  end
end
