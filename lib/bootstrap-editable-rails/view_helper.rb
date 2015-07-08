module Bootstrap::Editable::Rails
  module ViewHelper
    # Returns +text+ transformed into HTML suitable for textarea input.
    def textarea_format(text)
      html_escape(text).gsub(/\r\n|\r|\n/, '<br>').html_safe
    end

    # Returns a fully configured A tag for +object+, accessing the
    # attribute +method+, using +type+ as supported by the JS
    # library. Additional +options+ can be passed:
    #
    # "url" sets the URL to post data to manually, the default
    # is automatically derived from +object+.
    #
    # "title" sets the title for the popup, it is also applied
    # to the A tag itself.
    #
    # A block can be passed to generate the HTML content, it
    # defaults to the output of calling +method+ on +object+.
    #
    # If +type+ is set to "textarea", it will automatically pass
    # the result of +method+ on +object+ through the textformat
    # helper. This does not apply if a block is given.
    #
    # All other options will be passed to generating the A tag.
    # Defaults for A tag attributes "id" can "class" are generated
    # automatically but can be overridden.
    def inplace_editor_for object, method, type, options = {}
      options = options.dup

      url = options.delete(:url) { object }
      url = url_for(url) unless url.is_a? String
      object = object.last if object.is_a? Array

      id = "#{dom_id(object)}_#{method.to_s}"
      klass = "#{dom_class(object)}_#{method.to_s}"
      title = options.fetch(:title) { id.humanize }

      data = {
        type: type.to_s,
        resource: object.class.to_s.underscore,
        name: method.to_s,
        original_title: title,
        url: url
      }

      options.reverse_merge! id: id, class: ['editable', klass, options.delete(:class)].compact
      options.deep_merge! data: data

      if block_given?
        text = capture { yield(object) }.html_safe
      else
        text = object.public_send method
        text = textarea_format(text) if 'textarea' == type.to_s
      end

      content_tag :a, text, options
    end

  end
end
