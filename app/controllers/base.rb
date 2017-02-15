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

  get :sede, with: :id do
    @sede = Place.find(params[:id])
    @service_pestanas = Service.where(place: @sede, type: 1)
    @service_cejas = Service.where(place: @sede, type: 2)
    render :sede
  end

end
