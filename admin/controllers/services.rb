Aquiub::Admin.controllers :services do
  get :index do
    @title = "Services"
    @services = Service.all
    render 'services/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'service')
    @service = Service.new
    render 'services/new'
  end

  post :create do
    @service = Service.new(params[:service])
    if @service.save
      @title = pat(:create_title, :model => "service #{@service.id}")
      flash[:success] = pat(:create_success, :model => 'Service')
      params[:save_and_continue] ? redirect(url(:services, :index)) : redirect(url(:services, :edit, :id => @service.id))
    else
      @title = pat(:create_title, :model => 'service')
      flash.now[:error] = pat(:create_error, :model => 'service')
      render 'services/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "service #{params[:id]}")
    @service = Service.find(params[:id])
    if @service
      render 'services/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'service', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "service #{params[:id]}")
    @service = Service.find(params[:id])
    if @service
      if @service.update_attributes(params[:service])
        flash[:success] = pat(:update_success, :model => 'Service', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:services, :index)) :
          redirect(url(:services, :edit, :id => @service.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'service')
        render 'services/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'service', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Services"
    service = Service.find(params[:id])
    if service
      if service.destroy
        flash[:success] = pat(:delete_success, :model => 'Service', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'service')
      end
      redirect url(:services, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'service', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Services"
    unless params[:service_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'service')
      redirect(url(:services, :index))
    end
    ids = params[:service_ids].split(',').map(&:strip)
    services = Service.find(ids)
    
    if services.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Services', :ids => "#{ids.join(', ')}")
    end
    redirect url(:services, :index)
  end
end
