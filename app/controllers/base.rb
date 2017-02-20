Aquiub::App.controllers :base,  map: '/' do

  layout :application
  before do
    flash.clear
  end
  get :capacitaciones do
    @sedes = Place.all
    render :capacitaciones
  end
  get :index do
    @sedes = Place.all
    @promotions = Special.all
    render :index
  end

  get :catalogo do
    @sedes = Place.all
    render :catalogo
  end

  get :sede, with: :id do
    @sede = Place.find(params[:id])
    @service_pestanas = Service.where( type: 1)
    @service_cejas = Service.where(type: 2)
    render :sede
  end
  get :servicios do
    @service_pestanas = Service.where( type: 1)
    @service_cejas = Service.where(type: 2)
    @sedes = Place.all

    render :servicios
  end
end
