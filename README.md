# Calendar helper for Twitter Bootstrap and Rails

This gem provide simple and easy way to create calendar with Twitter Bootstrap and Rails.

## Installation

First of all you should include twitter bootstrap in your app. You can do it manually, or use [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails) gem.

### Installing the Less stylesheets

To use Less stylesheets, you'll need the [less-rails gem](http://rubygems.org/gems/less-rails), and one of [Javascript runtimes supported by CommonJS](https://github.com/cowboyd/commonjs.rb#supported-runtimes).

Include these lines in the Gemfile to install the gems from [RubyGems.org](http://rubygems.org):

```ruby
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "bootstrap_calendar_rails"
```

Then run `bundle install` from the command line:

    bundle install

Then run the bootstrap generator to add Calendar includes into your assets:

    rails generate calendar:install less

### Installing the CSS stylesheets

If you don't need to customize the stylesheets using Less, the only gem you need is the `bootstrap_calendar_rails` gem:

```ruby
gem "bootstrap_calendar_rails"
```

After running `bundle install`, run the generator:

    rails generate calendar:install static
    
## Usage

### Basic usage

You should use something like this in the view
```ruby
bootstrap_calendar Date.today {} do |date|
    date.day.to_s
end
```

it show you calendar for the current month.

### Advanced usage

You can specify another start week day. Use `start_day` key for this:

```ruby
bootstrap_calendar Date.today { start_day: :wednesday } do |date|
    date.day.to_s
end
```

You can extend day classes. Use `extra_day_classes` key and lambda for this:

```ruby
options = { extra_day_classes: lambda { |classes, date|
  classes << 'cal-day-daylight' if true  
  }
}
bootstrap_calendar Date.today, options do |date|
  date.day.to_s
end
```

## Example application

An example application is available at [sharpyfox/bootstrap_calendar_rails_example](https://github.com/sharpyfox/bootstrap_calendar_rails_example). You can view it running on heroku [here](http://calendar-example.herokuapp.com/). Contributions welcome.

![Screenshot](https://raw.github.com/sharpyfox/bootstrap_calendar_rails_example/master/public/screenshot.png "Screenshot")

## Inspiration

This gem are highly inspired by:

davidray and [davidray / twitter-bootstrap-calendar](https://github.com/davidray/twitter-bootstrap-calendar) Basically this gem is an adoptation `davidray / twitter-bootstrap-calendar` for my flavour

Serhioromano and [Serhioromano / bootstrap-calendar](https://github.com/Serhioromano/bootstrap-calendar) I stole all css markup from him

Thanks guys!

## Contribution

If you'd like to add features (or bug fixes) to improve the gem, you can fork the GitHub repo and [make pull requests](http://help.github.com/send-pull-requests/). Your code contributions are welcome!