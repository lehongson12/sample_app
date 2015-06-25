class MicropostsController < ApplicationController

	before_action :logged_in_user, only: [:edit, :update, :create, :destroy]
	before_action :correct_user, only: [:destroy, :edit, :update]

	def index
	    #@microposts = Micropost.all
	    @microposts = Micropost.all.paginate(page: params[:page])
	end

	  # GET /microposts/1
	def show
	    #@title = @micropost.title
	    @micropost = Micropost.find(params[:micropost_id] || params[:id])
	    @comment = Comment.new
	end

	  # GET /micropost/new
	def new
	    @micropost = Micropost.new
	end

	  # GET /micropost/1/edit
	def edit
	    @title = "Edit micropost"
	    unless @micropost.user_id == current_user.try(:id)
	    	flash[:success] = "Access denied."
	        redirect_to micropost_path
	    end
	end

	def update
	    @micropost = Micropost.find params[:id]
	    if @micropost.update_attributes micropost_params
	      flash[:success] = "Micropost updated successfully"
	      redirect_to @micropost
	    else
	      render 'edit'  
	    end
	end

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = Array.new
			render 'static_pages/home'
		end

	end

	def destroy
		#@micropost = Micropost.find(params[:id])
		@micropost.destroy
		#@micropost.comments.destroy
		flash[:success] = "Micropost deleted"
		redirect_back_or root_path
	end

	private
	def micropost_params
		params.require(:micropost).permit(:content, :picture, :title)
	end

	def correct_user
		@micropost = current_user.microposts.find_by(id: params[:id])
		redirect_to root_url if @micropost.nil?
	end

end
