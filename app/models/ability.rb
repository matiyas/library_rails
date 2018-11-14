class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show, :index], Post
    if user.present?
      can :manage, Post, user_id: user.id
      can :manage, :all if user.admin?
    end
  end
end
