# Postcode Anywhere

[ ![Codeship Status for simplemerchant/postcode_anywhere](https://codeship.io/projects/ade82b60-260e-0132-ce11-5220aac52c67/status)](https://codeship.io/projects/37329)

This is the Ruby gem for interacting with the [Postcode Anywhere API](http://www.postcodeanywhere.co.uk/support/webservices/) API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postcode_anywhere'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install postcode_anywhere

## Small disclaimer

The general architecture of this Gem is completely ripped off from that of the
[Twitter API Gem](https://github.com/sferik/twitter). Mainly because this structure has
worked well for us in the past and it's well tested.

## Usage

This Gem consists of a numer of available clients for each key service available from
Postcode Anywhere

The client can be configured upon instantiation.

```ruby
client = PostcodeAnywhere::Client.new(
  license_key:  'YOUR_API_KEY',
)

## Contributing

1. Fork it ( https://github.com/simplemerchant/postcode_anywhere/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
