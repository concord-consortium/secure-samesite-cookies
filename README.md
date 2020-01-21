# Rack::SecureSamesiteCookies

This rack middleware gem for Rails 3 updates outgoing cookies to add both the secure flag if the app is being served over https
and SameSite=None if the incoming lowercased HTTP_USER_AGENT string contains " chrome/".

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-secure_samesite_cookies',
    :git => 'git://github.com/concord-consortium/secure-samesite-cookies',
    :branch => 'production'
```

And then execute:

    $ bundle

## Usage

If you bundle "rack-same_site_cookies", Rack::SecureSamesiteCookies will be automatically inserted when started.

## Development

After checking out the repo, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/concord-consortium/secure_samesite_cookies.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
