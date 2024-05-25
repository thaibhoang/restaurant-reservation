class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Business)
      stored_location_for(resource) || business_path(resource) || root_path
    else
      root_path
    end
  end
end
