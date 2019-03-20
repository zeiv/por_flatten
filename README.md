# PorFlatten

[![Gem Version](https://badge.fury.io/rb/por_flatten.svg)](https://badge.fury.io/rb/por_flatten) [![Build Status](https://travis-ci.org/zeiv/por_flatten.svg?branch=master)](https://travis-ci.org/zeiv/por_flatten) [![Test Coverage](https://api.codeclimate.com/v1/badges/1b7dbc55ef7b9827f3c8/test_coverage)](https://codeclimate.com/github/zeiv/por_flatten/test_coverage) [![Maintainability](https://api.codeclimate.com/v1/badges/1b7dbc55ef7b9827f3c8/maintainability)](https://codeclimate.com/github/zeiv/por_flatten/maintainability) [![Inline docs](http://inch-ci.org/github/zeiv/por_flatten.svg?branch=master)](http://inch-ci.org/github/zeiv/por_flatten)

This gem adds a Plain-Old-Ruby implementation of an array flattening method as `Array#por_flatten`.  Why?  Because `Array#flatten` is implemented in C.
Disclaimer: Methods used by this gem may be implemented in C.

Serious Disclaimer: This gem is an example.  `Array#flatten`, being written in C, will be theoretically faster than `Array#por_flatten`.  There is really no reason you should be using this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'por_flatten'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install por_flatten

## Usage

__Note__: By default `Array#por_flatten` allows only integer and array elements.  To use this gem with identical functionality to the `Array#flatten` method (minus the ability to specify flattening levels), simply pass in an option like `array.por_flatten(integers_only: false)`

```ruby
a = [1, 2, [3, 4]]
a.por_flatten
=> [1, 2, 3, 4]

b = [['one', 'two',], ['three', 'four']]
b.por_flatten(integers_only: false)
=> ['one', 'two', 'three', 'four']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/por_flatten. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PorFlatten project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/por_flatten/blob/master/CODE_OF_CONDUCT.md).
