class ListsController < ApplicationController	
  before_action :authenticate_user!

  helper_method :list
  helper_method :user_lists

  def index
    @user = User.find_by_username(params[:username])
    @lists = @user.lists.page(params[:page]).per(5).order('created_at DESC')
    @public_lists_count = @lists.where(private: false).count
  end

  def new
  	@list = current_user.lists.new
  end

  def create
  	@list = current_user.lists.new(list_params)

  	if @list.save
	    #TODO: Make this flash directly on user_lists_path
	    #flash[:success] = @list[:name] + " has been successfully created !"
      redirect_to user_lists_path(current_user.username)
   	else
	    render :new
  	end
  end

  def edit
  end

  def update
    @list = list
    @list.update(list_params)
    if @list.save
      redirect_to user_lists_path(current_user.username)
    else
      render :edit
    end
  end

  def show
    @user = User.find_by_username(params[:username])
    @lists = List.where(user_id: @user.id)
  end

  def destroy
    deleted_list = current_user.lists.find(params[:id])
    deleted_list.destroy
    redirect_to user_lists_path(current_user.username)
  end

  private

    def user_lists
      User.find_by_username(params[:username]).lists
    end

    def list
      user_lists.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :description, :private)
    end
end
