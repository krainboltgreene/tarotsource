class PagesController < ApplicationController
  before_action :authenticate_account!, if: :internal?

  def show
    if File.exists?(Rails.root.join("app", "views", "pages", "#{params[:id]}.html.erb"))
      render params[:id]
    else
      redirect_to "/404.html"
    end
  end

  private def internal?
    case params[:id]
    when "dashboard" then true
    else false
    end
  end
end
