# Bootstrap Editable Rails

In-place editing with Twitter Bootstrap for Rails

This gem is based on X-editable (v1.1.1) which is the new version of Bootstrap Editable.

https://github.com/vitalets/x-editable

## Demo & Documents

See http://vitalets.github.com/x-editable

## Installation

Add this line to your application's Gemfile:

    gem 'bootstrap-editable-rails'

And then execute:

    $ bundle

## Usage

Write the top of `app/assets/javascripts/application.js` like this:

```javascript
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require_tree .
```

and need to load `bootstrap-editable.css` at the place where you like.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
