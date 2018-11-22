module Admins
  class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]
    load_and_authorize_resource

    # GET /admins/posts
    # GET /admins/posts.json
    def index
      posts = Post.all.sort_by(&:created_at).reverse
      @posts = posts.paginate(page: params[:page])
    end

    # GET /admins/posts/1
    # GET /admins/posts/1.json
    def show
    end

    # GET /admins/posts/new
    def new
      @post = Post.new
    end

    # GET /admins/posts/1/edit
    def edit
    end

    # POST /admins/posts
    # POST /admins/posts.json
    def create
      @post = current_user.posts.build(post_params)
      respond_to do |format|
        if @post.save
          flash[:success] = 'Post was successfully created.'
          format.html { redirect_to [:admins, @post]}
          format.json { render :show, status: :created, location: [:admins, @post] }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admins/posts/1
    # PATCH/PUT /admins/posts/1.json
    def update
      respond_to do |format|
        if @post.update(post_params)
          flash[:notice] = 'Post was successfully updated.'
          format.html { redirect_to [:users, @post] }
          format.json { render :show, status: :ok, location: [:admins, @post] }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admins/posts/1
    # DELETE /admins/posts/1.json
    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to users_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private


    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
  end
end
