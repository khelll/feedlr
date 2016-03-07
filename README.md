# Feedlr - A Ruby interface to Feedly API

[![Gem Version](https://badge.fury.io/rb/feedlr.svg)](http://badge.fury.io/rb/feedlr) [![Build Status](https://travis-ci.org/khelll/feedlr.svg?branch=master)](https://travis-ci.org/khelll/feedlr) [![Coverage Status](https://coveralls.io/repos/khelll/feedlr/badge.png)](https://coveralls.io/r/khelll/feedlr) [![Dependency Status](https://gemnasium.com/khelll/feedlr.svg)](https://gemnasium.com/khelll/feedlr) [![Code Climate](https://codeclimate.com/github/khelll/feedlr/badges/gpa.svg)](https://codeclimate.com/github/khelll/feedlr)

A Ruby interface to Feedly [API](http://developer.feedly.com/).

## API Support

- [x] Categories API
- [x] Entries API
- [x] Evernote API
- [x] Facebook API
- [x] Feeds API
- [x] Markers API
- [x] Microsoft API
- [x] Mixes API
- [x] OPML API
- [x] Preferences API
- [x] Profile API
- [x] Search API
- [x] Streams API
- [x] Subscriptions API
- [x] Tags API
- [x] Topics API
- [x] Twitter API
- [x] URL Shortener API

## Supported Ruby Versions

Feedlr is tested under 2.0, 2.1, 2.2, JRuby(1.9 mode) and Rubinius 2.2.7.

## Installation

Add this line to your application's Gemfile:

    gem 'feedlr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feedlr

## Usage

### Basic usage

```ruby
require 'feedlr'
client = Feedlr::Client.new(oauth_access_token: 'oauth access token')
# Fetch user categories
p client.user_categories
# Fetch user subscriptions
p client.user_subscriptions
```

### Detailed API

You can easily inspect the available client methods:

```ruby
client = Feedlr::Client.new
p client.api_methods
```

Also, the gem is fairly documented. Browse the YARD [documentaion](http://rubydoc.info/gems/feedlr/) for more information.

### Global configuration

You can have a global configuration that instances can use. For example,  you can have the following in some initializer's code:

```ruby
Feedlr.configure do |config|
  config.oauth_access_token = 'oauth access token'
  config.sandbox = true
  config.logger = SomeCustomLogger.new
end
```
And elsewhere you can do:
```ruby
client = Feedlr::Client.new
```

### Instance initialization

You can set the oauth access token, a custom logger(if needed) and whether or not to use the client on sandbox(develpment) mode:

```ruby
require 'logger'
client = Feedlr::Client.new(
  oauth_access_token: 'oauth access token',
  sandbox: true,
  logger: Logger.new(STDOUT)
)
```

### Pagination

Some requests support pagination(continuation)

```ruby
cursor = client.stream_entries_contents(stream_id)
cursor.each { |page| p page.items.map(&:title) }
```

For those requests, you will get enumerable paginated results `Feedlr::Cursor`. Calling `each` or `each_page` on a `Feedlr::Cursor` object yields the response and any follow up responses.

There are a few other helper methods that make it easy to control response paging:

```ruby
cursor.last_page? #=> false
cursor.next_page? #=> true

# gets the next page, returns nil for the last page
resp = cursor.next_page

# gets each response in a loop
resp = cursor.next_page until cursor.last_page?
```

### Rate limiting

The client deals with a variaty of [errors](http://rubydoc.info/gems/feedlr/Feedlr/Error). The errors have a corresponding [rate_limit](http://rubydoc.info/gems/feedlr/Feedlr/RateLimit) object that maps to the returned rate limiting [headers](http://developer.feedly.com/v3/#rate-limiting) if any.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
