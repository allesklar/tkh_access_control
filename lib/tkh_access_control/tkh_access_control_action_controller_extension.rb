module TkhAccessControlActionControllerExtension
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods

    private

    def current_user
      @current_user ||= User.find_by!(auth_token: cookies[:auth_token]) if cookies[:auth_token]
    end

    def authenticate
      if current_user.nil?
        session[:target_page] = request.url if session[:target_page].nil?
        redirect_to login_url, alert: t('authentication.warning.login_needed')
      end
    end

    def authenticate_with_admin
      unless administrator?
        session[:target_page] = request.url if session[:target_page].nil?
        redirect_to safe_root_url, alert: t('authentication.warning.restricted_access')
      end
    end

    def require_permission_to( permission )
      unless current_user.is_allowed_to? permission
        redirect_to safe_root_url, alert: t('authentication.warning.restricted_access')
      end
    end

    def administrator?
      current_user && current_user.has_role?('admin')
    end

    def safe_root_url
      defined?(root_url) ? root_url : '/'
    end

  end
end
