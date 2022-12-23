class ApplicationController < ActionController::Base
  #ログイン前のアクセス制限
  before_action :authenticate_end_user!, except: [:top]
end
