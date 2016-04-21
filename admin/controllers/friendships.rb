EatOriginsServer::Admin.controllers :friendships do
  get :index do
    @title = "Friendships"
    @friendships = Friendship.all

    render 'friendships/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'friendship')
    @friendship = Friendship.new
    render 'friendships/new'
  end

  post :create do
    @friendship = Friendship.new(params[:friendship])
    if @friendship.save
      @title = pat(:create_title, :model => "friendship #{@friendship.id}")
      flash[:success] = pat(:create_success, :model => 'Friendship')
      params[:save_and_continue] ? redirect(url(:friendships, :index)) : redirect(url(:friendships, :edit, :id => @friendship.id))
    else
      @title = pat(:create_title, :model => 'friendship')
      flash.now[:error] = pat(:create_error, :model => 'friendship')
      render 'friendships/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "friendship #{params[:id]}")
    @friendship = Friendship.find(params[:id])
    if @friendship
      render 'friendships/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'friendship', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "friendship #{params[:id]}")
    @friendship = Friendship.find(params[:id])
    if @friendship
      if @friendship.update_attributes(params[:friendship])
        flash[:success] = pat(:update_success, :model => 'Friendship', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:friendships, :index)) :
          redirect(url(:friendships, :edit, :id => @friendship.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'friendship')
        render 'friendships/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'friendship', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Friendships"
    friendship = Friendship.find(params[:id])
    if friendship
      if friendship.destroy
        flash[:success] = pat(:delete_success, :model => 'Friendship', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'friendship')
      end
      redirect url(:friendships, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'friendship', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Friendships"
    unless params[:friendship_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'friendship')
      redirect(url(:friendships, :index))
    end
    ids = params[:friendship_ids].split(',').map(&:strip)
    friendships = Friendship.find(ids)
    
    if Friendship.destroy friendships
    
      flash[:success] = pat(:destroy_many_success, :model => 'Friendships', :ids => "#{ids.join(', ')}")
    end
    redirect url(:friendships, :index)
  end
end
