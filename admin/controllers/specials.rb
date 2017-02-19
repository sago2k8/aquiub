Aquiub::Admin.controllers :specials do
  get :index do
    @title = "Specials"
    @specials = Special.all
    render 'specials/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'special')
    @special = Special.new
    render 'specials/new'
  end

  post :create do
    @special = Special.new(params[:special].except('picture'))
    @special.picture = params[:special][:picture]
    if @special.save
      @title = pat(:create_title, :model => "special #{@special.id}")
      flash[:success] = pat(:create_success, :model => 'Special')
      params[:save_and_continue] ? redirect(url(:specials, :index)) : redirect(url(:specials, :edit, :id => @special.id))
    else
      @title = pat(:create_title, :model => 'special')
      flash.now[:error] = pat(:create_error, :model => 'special')
      render 'specials/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "special #{params[:id]}")
    @special = Special.find(params[:id])
    if @special
      render 'specials/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'special', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "special #{params[:id]}")
    @special = Special.find(params[:id])
    if @special
      if @special.update_attributes(params[:special].except('picture'))
        @special.picture = params[:special][:picture]
        if @special.save
          flash[:success] = pat(:update_success, :model => 'Special', :id =>  "#{params[:id]}")
          params[:save_and_continue] ?
            redirect(url(:specials, :index)) :
            redirect(url(:specials, :edit, :id => @special.id))
        else
          flash.now[:error] = pat(:update_error, :model => 'special')
          render 'specials/edit'
        end
      else
        flash.now[:error] = pat(:update_error, :model => 'special')
        render 'specials/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'special', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Specials"
    special = Special.find(params[:id])
    if special
      if special.destroy
        flash[:success] = pat(:delete_success, :model => 'Special', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'special')
      end
      redirect url(:specials, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'special', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Specials"
    unless params[:special_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'special')
      redirect(url(:specials, :index))
    end
    ids = params[:special_ids].split(',').map(&:strip)
    specials = Special.find(ids)
    
    if specials.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Specials', :ids => "#{ids.join(', ')}")
    end
    redirect url(:specials, :index)
  end
end
