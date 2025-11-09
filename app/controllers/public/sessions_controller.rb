# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  #before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :configure_sign_in_params, only: [:create]
  
  #protected
  
  #def configure_permitted_parameters
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  #end
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
    def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message! :notice, :signed_out if signed_out
      yield resource if resource

      respond_to do |format|
        format.html { redirect_to after_sign_out_path_for(resource_name) }
    
      end
    end

  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
