class Ability
  include CanCan::Ability

  def initialize(user)
    can %i[show index], Post
    if user.present?
      can :create, Post
      can :manage, Post, user_id: user.id
      can :manage, :all if user.role? :admin
    end
  end
end
