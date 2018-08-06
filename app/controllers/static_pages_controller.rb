class StaticPagesController < ApplicationController
  def home
  end

  def private
    unless logged_in?
      redirect_to login_path, :flash => { :danger => "Pour accéder à cette page, il faut d'abord vous connecter." }
      end
  end
end
