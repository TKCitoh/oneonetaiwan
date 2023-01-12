class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!, except: [:top]
end
