class Public::ApplicationController < ApplicationController
  before_action :authenticate_end_user!, except: [:top]
end