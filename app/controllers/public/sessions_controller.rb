# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user   # ユーザーをログインさせる
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected
  # 退会しているかを判断するメソッド
  def end_user_state
    ## 入力されたemailからアカウントを1件取得
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@end_user
    ## 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @end_user.valid_password?(params[:end_user][:password])
    ##
    if @end_user.is_deleted
    redirect_to new_end_user_registration_path
    else
    end
    end
  end
end
