class Public::HomesController < ApplicationController
  def top
    render 'public/homes/top'
  end

  def about
    render 'public/homes/about'
  end
  
end
