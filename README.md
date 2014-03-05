# TZ::Formater
[![Build Status](https://travis-ci.org/tonkonogov/TZ-formater.png?branch=master)](https://travis-ci.org/tonkonogov/TZ-formater)
[![Coverage Status](https://coveralls.io/repos/tonkonogov/TZ-formater/badge.png)](https://coveralls.io/r/tonkonogov/TZ-formater)
[![Code Climate](https://codeclimate.com/github/tonkonogov/TZ-formater.png)](https://codeclimate.com/github/tonkonogov/TZ-formater)
[![Dependency Status](https://gemnasium.com/tonkonogov/TZ-formater.png)](https://gemnasium.com/tonkonogov/TZ-formater)

Ruby gem for timezone format converting.

This gem provides four class for converting a timezone format into each other.
* PosixTZ
* OlsonTZ
* WinTZ
* WinRegTZ

NOTE: this gem doesn't modify base ruby classes

## Example of timezones

Drawing on the example of the Alaskan timezone:
* Olson - America/Anchorage
* POSIX - AKST9AKDT,M3.2.0,M11.1.0
* Win   - (UTC-09:00) Alaska
* Windows registry - Alaskan Standard Time

## Requirements

This gem uses only built-in tools.
Gem is fully tested with MRI 1.9.2, 1.9.3, 2.0, 2.1 and jruby in 1.9 mode

## Installation

Add this line to your application's Gemfile:

    gem 'TZ-formater'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install TZ-formater

## Usage

Get all timezones in current format:

    TZFormater::PosixTZ.all

Create timezone with specific format:

    TZFormater::OlsonTZ.new('Europe/London')
    TZFormater::PosixTZ.new('MST7')

Get string representation for current timezone

    london_olson.name  # => "Europe/London"

Convert timezone to the other format (returns new object):

    olson_format.to_win
    olson_format.to_win_reg
    olson_format.to_posix
    posix_format.to_olson

Note: you able to convert, for example, a timezone in the posix format to one in the posix format but instead of converting the self object will be returned.

Get timezone offset:

    london_win.offset # => 0

### More complicated examples

Get name of converted timezone:

    london_olson.to_posix.name # => "GMT0BST,M3.5.0/1,M10.5.0"

Get string represantation of all timezones:

    TZFormater::PosixTZ.all.map(&:name) # => Very long array with posix timezones

Get list of timezones sorted by utc offset:

    TZFormater::WinTZ.all.sort_by(&:offset)

## Contributing

1. Fork it ( http://github.com/tonkonogov/TZ-formater/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
