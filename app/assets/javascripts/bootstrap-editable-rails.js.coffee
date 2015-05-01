# bootstrap-editable-rails.js.coffee
# Modify parameters of X-editable suitable for Rails.

jQuery ($) ->
  $.fn.editableform.defaults.ajaxOptions =
    type    : 'PUT' # TODO: should be 'POST' when create new object
    dataType: 'json'
  $.fn.editableform.defaults.pk = 'unused' # necessary to fill some value

  EditableForm = $.fn.editableform.Constructor

  # Patch for extendable params
  # remove this part when the pull request is accepted
  # https://github.com/vitalets/x-editable/pull/511
  `
  EditableForm.prototype.save = function (submitValue) {
    //try parse composite pk defined as json string in data-pk
    this.options.pk = $.fn.editableutils.tryParseJson(this.options.pk, true);

    var pk = (typeof this.options.pk === 'function') ? this.options.pk.call(this.options.scope) : this.options.pk,
    /*
     send on server in following cases:
     1. url is function
     2. url is string AND (pk defined OR send option = always)
     */
      send = !!(typeof this.options.url === 'function' || (this.options.url && ((this.options.send === 'always') || (this.options.send === 'auto' && pk !== null && pk !== undefined)))),
      params;

    if (send) { //send to server
      this.showLoading();

      params = this.initParams(submitValue, pk);

      //additional params
      if (typeof this.options.params === 'function') {
        params = this.options.params.call(this.options.scope, params);
      } else {
        //try parse json in single quotes (from data-params attribute)
        this.options.params = $.fn.editableutils.tryParseJson(this.options.params, true);
        $.extend(params, this.options.params);
      }

      if (typeof this.options.url === 'function') { //user's function
        return this.options.url.call(this.options.scope, params);
      } else {
        //send ajax to server and return deferred object
        return $.ajax($.extend({
          url: this.options.url,
          data: params,
          type: 'POST'
        }, this.options.ajaxOptions));
      }
    }
  };
  `

  EditableForm.prototype.initParams = (value, pk) ->
    obj = {}
    params = {}
    obj[@options.name] = value
    if @options.resource
      params[@options.resource] = obj
    else
      params = obj
    params
