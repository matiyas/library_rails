class Ability
  include CanCan::Ability

  def initialize(user, namespace)
    case namespace
    when 'Users'
      can %i[show index], Post
      if user.present?
        can :create, Post
        can :manage, Post, user_id: user.id
        can :manage, :all if user.role? :admin
      end
    when 'Admins'
      if user.present?
        can %i[show index create], Post if user.role? :admin
        can %i[edit destroy], Post, user_id: user.id
      end
    end
  end
end