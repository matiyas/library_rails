class Api::Users::PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index]
  skip_before_action :verify_authenticity_token
  load_and_authorize_resource

  # GET /users/posts.json
  def index
    if user_signed_in?
      @posts = current_user.posts.sort_by(&:created_at).reverse
    end
  end

  # GET /users/posts/1.json
  def show; end

  # GET /users/posts/new
  def new
    @post = Post.new
  end

  # GET /users/posts/1/edit
  def edit; end

  # POST /users/posts
  # POST /users/posts.json
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.json do
          render json: { notice: 'Post was created successfully' },
                 status: :created, location: [:api, :users, @post]
        end
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/posts/1
  # PATCH/PUT /users/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.json do
          render json: { notice: 'Post was updated successfully.' },
                 status: :ok
        end
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.json do
        render json: { notice: 'Post was successfully destroyed.' },
               status: :ok
      end
    end
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :image)
  end
end