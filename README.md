# Bootstrap Editable Rails

In-place editing with Twitter Bootstrap for Rails

This gem is based on X-editable (v1.4.1) which is the new version of Bootstrap Editable.

https://github.com/vitalets/x-editable

## Demo & Documents

See http://vitalets.github.com/x-editable

## Installation

Add this line to your application's Gemfile:

    gem 'bootstrap-editable-rails'

And then execute:

    $ bundle

## Usage

### JavaScript & Stylesheet

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

### HTML

Follow the documents of X-editable above.

Additional required attribute is `resource`.

```html
<a href="#" id="username" data-type="text" data-resource="post" data-name="username" data-url="/posts/1" data-original-title="Enter username">superuser</a>
```

then, sends `PUT /posts/1` request with the body:

```
post[username]=superuser
```

When using `textarea` type, `textarea_format` helper method for formatting line breaks is available.

```html
<a href="#" id="body" data-type="textarea" data-resource="post" data-name="body" data-url="/posts/1" data-original-title="Enter body">
  <%= textarea_format(@post.body) %>
</a>
```

### Controller

PostsController receives the parameters

```
{ "id" => "1", "post" => { "username" => "superuser" } }
```

and must respond with 2xx (means _success_) status code if successful.

For example, scaffold works well by 204 because default dataType is json.

```ruby
def update
  @post = Post.find(params[:id])

  respond_to do |format|
    if @post.update_attributes(params[:post])
      format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      format.json { head :no_content } # 204 No Content
    else
      format.html { render action: "edit" }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
