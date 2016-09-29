jQuery(function($) {
  var EditableForm;
  EditableForm = $.fn.editableform.Constructor;
  if (EditableForm.prototype.saveWithUrlHook == null) {
    EditableForm.prototype.saveWithUrlHook = function(value) {
      var originalUrl, resource;
      originalUrl = this.options.url;
      resource = this.options.resource;
      this.options.url = (function(_this) {
        return function(params) {
          var obj;
          if (typeof originalUrl === 'function') {
            return originalUrl.call(_this.options.scope, params);
          } else if ((originalUrl != null) && _this.options.send !== 'never') {
            obj = {};
            obj[params.name] = params.value;
            if (resource) {
              params[resource] = obj;
            } else {
              params = obj;
            }
            delete params.name;
            delete params.value;
            delete params.pk;
            return $.ajax($.extend({
              url: originalUrl,
              data: params,
              type: 'PUT',
              dataType: 'json'
            }, _this.options.ajaxOptions));
          }
        };
      })(this);
      return this.saveWithoutUrlHook(value);
    };
    EditableForm.prototype.saveWithoutUrlHook = EditableForm.prototype.save;
    return EditableForm.prototype.save = EditableForm.prototype.saveWithUrlHook;
  }
});
