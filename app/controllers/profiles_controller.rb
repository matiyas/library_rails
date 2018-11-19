class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    # authorize! :show, @user
  end
end