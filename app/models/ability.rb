class Ability
  include CanCan::Ability

  def initialize(user)
    can :show, Post
    if user.present?
      # can :create, Post
      can :manage, Post, user_id: user.id
      can :manage, :all if user.admin?
    end
  end
end
