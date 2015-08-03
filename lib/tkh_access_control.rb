require "tkh_access_control/version"
# require 'bcrypt-ruby'
require 'simple_form'
require 'stringex'
require 'tkh_access_control/tkh_access_control_action_controller_extension'
require 'tkh_access_control/tkh_access_control_helper'
# require 'tkh_mailing_list' # debugging this

module TkhAccessControl
  class Engine < ::Rails::Engine
    # to extend the application helper in the host app
    initializer 'tkh_access_control.helper' do |app|
      ActionView::Base.send :include, TkhAccessControlHelper
    end
    # to extend the application_controller in the host app
    initializer 'tkh_access_control.controller' do |app|
      ActiveSupport.on_load(:action_controller) do
         include TkhAccessControlActionControllerExtension
      end
    end
  end
end
