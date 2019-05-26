module TkhAccessControlHelper
  def self.included(base)
    base.send(:include, InstanceMethods)
    # base.before_action :current_user
    # base.after_action :my_method_2
  end

  module InstanceMethods
    # duplicated from action controller extension. there must be a better way
    def current_user
      @current_user ||= User.find_by!(auth_token: cookies[:auth_token]) if cookies[:auth_token]
    end

    # duplicated from action controller extension. there must be a better way
    # FIXME - change logic of this method
    def administrator?
      @administrator ||= current_user && current_user.has_role?('admin')
    end
  end
end
