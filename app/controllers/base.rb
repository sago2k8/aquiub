Aquiub::App.controllers :base,  map: '/' do

  layout :application

  before do
    flash.clear
  end

  get :index do
    render :index
  end

  get :catalogo do
    render :catalogo
  end

end
