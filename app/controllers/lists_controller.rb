class ListsController < ApplicationController	
  before_action :authenticate_user!

  helper_method :list
  helper_method :user_lists

  def index
    @lists = current_user.lists.page(params[:page]).per(5).order('created_at DESC')
  end

  def new
  	@list = user_lists.new
  end

  def create
  	@list = user_lists.new(list_params)

  	if @list.save
	    #TODO: Make this flash directly on user_lists_path
	    #flash[:success] = @list[:name] + " has been successfully created !"
      redirect_to user_lists_path(current_user.username)
   	else
	  render 'new'
  	end
  end

  def edit
  end

  def update
    list
    @list.update(list_params)
    if @list.save
      redirect_to user_lists_path(current_user.username)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    deleted_list = list.destroy
    flash[:success] = "Income type \"#{list.name}\" was deleted!"
    redirect_to user_lists_path(current_user.username)
  end

  private

    def user_lists
      @user_lists ||= current_user.lists
    end

    def list
      @list ||= user_lists.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :description)
    end
end
