Aquiub::Admin.controllers :places do
  get :index do
    @title = "Places"
    @places = Place.all
    render 'places/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'place')
    @place = Place.new
    render 'places/new'
  end

  post :create do
    @place = Place.new(params[:place])
    if @place.save
      @title = pat(:create_title, :model => "place #{@place.id}")
      flash[:success] = pat(:create_success, :model => 'Place')
      params[:save_and_continue] ? redirect(url(:places, :index)) : redirect(url(:places, :edit, :id => @place.id))
    else
      @title = pat(:create_title, :model => 'place')
      flash.now[:error] = pat(:create_error, :model => 'place')
      render 'places/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "place #{params[:id]}")
    @place = Place.find(params[:id])
    if @place
      render 'places/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'place', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "place #{params[:id]}")
    @place = Place.find(params[:id])
    if @place
      if @place.update_attributes(params[:place].except('pictures'))
        params[:place][:pictures].each do |image|
          PlacePicture.create!(place: @place, picture: image)
        end
        flash[:success] = pat(:update_success, :model => 'Place', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:places, :index)) :
          redirect(url(:places, :edit, :id => @place.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'place')
        render 'places/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'place', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Places"
    place = Place.find(params[:id])
    if place
      if place.destroy
        flash[:success] = pat(:delete_success, :model => 'Place', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'place')
      end
      redirect url(:places, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'place', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Places"
    unless params[:place_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'place')
      redirect(url(:places, :index))
    end
    ids = params[:place_ids].split(',').map(&:strip)
    places = Place.find(ids)
    
    if places.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Places', :ids => "#{ids.join(', ')}")
    end
    redirect url(:places, :index)
  end
end
