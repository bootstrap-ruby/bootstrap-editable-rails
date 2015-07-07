# bootstrap-editable-rails.js.coffee
# Modify parameters of X-editable suitable for Rails.

jQuery ($) ->
  EditableForm = $.fn.editableform.Constructor
  unless EditableForm::saveWithUrlHook?
    EditableForm::saveWithUrlHook = (value) ->
      originalUrl = @options.url
      resource = @options.resource
      @options.url = (params) =>
        # TODO: should not send when create new object
        if typeof originalUrl == 'function' # user's function
          originalUrl.call(@options.scope, params)
        else if originalUrl? && @options.send != 'never'
          # send ajax to server and return deferred object
          obj = {}
          obj[params.name] = params.value
          # support custom inputtypes (eg address)
          if resource
            params[resource] = obj
          else
            params = obj
          delete params.name
          delete params.value
          delete params.pk
          $.ajax($.extend({
            url     : originalUrl
            data    : params
            type    : 'PATCH' # TODO: should be 'POST' when create new object
            dataType: 'json'
          }, @options.ajaxOptions))
      @saveWithoutUrlHook(value)
    EditableForm::saveWithoutUrlHook = EditableForm::save
    EditableForm::save = EditableForm::saveWithUrlHook
