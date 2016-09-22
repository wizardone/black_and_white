# BlackAndWhite
[![Build Status](https://travis-ci.org/wizardone/black_and_white.svg?branch=master)](https://travis-ci.org/wizardone/black_and_white)
[![codecov](https://codecov.io/gh/wizardone/black_and_white/branch/master/graph/badge.svg)](https://codecov.io/gh/wizardone/black_and_white)


### A/B Testing made easy

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'black_and_white'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install black_and_white

## Usage
Black And White is meant to work with Rails for the moment. In order to
use it first run:
```ruby
rails g black_and_white:config
```
this will create a `black_and_white.rb` config file in
`config/initializers` with some default values. The file looks like this:
```ruby
BlackAndWhite.configure do |config|
  config.bw_class = 'User'
  config.bw_class_table = :users
  config.bw_main_table = :ab_test
  config.bw_join_table = :ab_tests_users
end
  
BlackAndWhite::Hooks.init
```

After this run:
```ruby
rails g black_and_white:migrations
```
this will create the necessary migrations in the `db/migrate` folder.
Review them and then feel free to migrate.

### For ActiveRecord objects:
Include the black_and_white module for activerecord interactions. The base class may have multiple a/b tests:
```ruby
class User < ActiveRecord::Base
  include BlackAndWhite::ActiveRecord
end
```

To create a new A/B test you can run:
```ruby
BlackAndWhite.create(name: 'My Test', active: true)
```
By default all created tests are inactive.
To add existing users (or any other object) to the A/B Test you can call:
```ruby
user.ab_participate!('My Test')
user.ab_tests.size
=> 1
user.ab_participates?('My Test')
=> true
```
You can also supply an additional block which is evaluated:
```ruby
user.ab_participate!('My Test') do |user|
  user.admin? # returns true, user is added to the ab test
end
```
A couple of additional options are supported as well:

`join_inactive` => Join an a/b test, even if it is inactive
```ruby
user.ab_participate!('My Inactive test', join_inactive: true)
```
`raise_on_missing` => raises a custom error message if the given a/b test does not exist
```ruby
user.ab_participate!('My Inactive test', raise_on_missing: true)
=> AbTestError, "no A/B Test with name My Inactive test exists or it is not active"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wizardone/black_and_white. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
