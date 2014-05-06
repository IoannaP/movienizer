class ListsController < ApplicationController	
  before_action :authenticate_user!

  helper_method :list

  def index
  end

  def new
  	@list = user_lists.new
  end

  def create
  	@list = user_lists.new(list_params)

  	if @list.save
      flash[:success] = @list[:name] + " has been successfully created !"
      redirect_to user_lists_path(current_user)
   	else
	  render 'new'
  	end
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
