class StoresController < ApplicationController
  before_action :authenticate_account!

  def show
    @store = Store.find(params[:id])
  end

  def new
    @store = current_account.build_store
  end

  def create
    @store = current_account.build_store(**StoreSanitizer.new(params))

    if @store.save!
      redirect_to store_url(@store)
    else
      render :new
    end
  end
end
