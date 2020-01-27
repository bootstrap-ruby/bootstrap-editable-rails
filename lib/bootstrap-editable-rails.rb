require 'bootstrap-editable-rails/version'
require 'bootstrap-editable-rails/view_helper'

module Bootstrap
  module Editable
    module Rails
      class Engine < ::Rails::Engine
        initializer 'bootstrap-editable-rails' do |app|
          ::ActiveSupport.on_load(:action_view) do
            ::ActionView::Base.send :include, Bootstrap::Editable::Rails::ViewHelper
          end
          app.config.assets.precompile << "bootstrap-editable/**/*.{gif,png}"
        end
      end
    end
  end
end
