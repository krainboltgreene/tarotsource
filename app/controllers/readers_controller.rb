class ReadersController < ApplicationController
  before_action :authenticate_account!

  def new
    @account = current_account
  end
end
