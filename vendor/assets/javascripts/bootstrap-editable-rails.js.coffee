# bootstrap-editable-rails.js.coffee
# Modify parameters of X-editable suitable for Rails.

jQuery ($) ->
  EditableForm = $.fn.editableform.Constructor
  EditableForm.prototype.saveWithUrlHook = (value) ->
    originalUrl = @options.url
    resource = @options.resource
    @options.url = (params) ->
      # TODO: should not send when create new object
      if typeof originalUrl == 'function' # user's function
        originalUrl.call(@, params)
      else # send ajax to server and return deferred object
        obj = {}
        data = {}
        obj[params.name] = params.value
        data[resource] = obj
        ajaxOptions = $.extend({
          url     : originalUrl
          data    : data
          type    : 'PUT' # TODO: should be 'POST' when create new object
          dataType: 'json'
        }, @options.ajaxOptions)
        $.ajax(ajaxOptions)
    @saveWithoutUrlHook(value)
  EditableForm.prototype.saveWithoutUrlHook = EditableForm.prototype.save
  EditableForm.prototype.save = EditableForm.prototype.saveWithUrlHook
