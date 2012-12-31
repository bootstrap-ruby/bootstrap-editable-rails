# bootstrap-editable-rails.js.coffee
# Modify parameters of X-editable suitable for Rails.

jQuery ($) ->
  EditableForm = $.fn.editableform.Constructor
  EditableForm.prototype.saveWithUrlHook = (value) ->
    originalUrl = @options.url
    resource = @options.resource
    methodType = @options.method || "PUT"
    @options.url = (params) =>
      # TODO: should not send when create new object
      if typeof originalUrl == 'function' # user's function
        originalUrl.call(@options.scope, params)
      else # send ajax to server and return deferred object
        obj = {}
        obj[params.name] = params.value
        params[resource] = obj
        delete params.name
        delete params.value
        delete params.pk
        $.ajax($.extend({
          url     : originalUrl
          data    : params
          type    : methodType
          dataType: 'json'
        }, @options.ajaxOptions))
    @saveWithoutUrlHook(value)
  EditableForm.prototype.saveWithoutUrlHook = EditableForm.prototype.save
  EditableForm.prototype.save = EditableForm.prototype.saveWithUrlHook
