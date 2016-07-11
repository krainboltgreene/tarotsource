class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected def devise_parameter_sanitizer
    case
    when resource_class == Account then AccountSanitizer.new(Account, :account, params)
    else super
    end
  end

  private def after_sign_in_path_for(resource)
    request.referer || dashboard_url
  end

  private def after_sign_up_path_for(resource)
    dashboard_url
  end

  private def after_sign_out_path_for(resource)
    root_url
  end

  private def after_update_path_for(resource)
    dashboard_url
  end
end
