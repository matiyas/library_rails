class Ability
  include CanCan::Ability

  def initialize(user, namespace)
    case namespace
    when 'Users'
      can %i[show index], Post
      can :manage, User, id: user&.id
      if user.present?
        can :create, Post
        can :manage, Post, user_id: user.id
        can :manage, :all if user.role? :admin
      end
    when 'Admins'
      if user.present?
        can %i[show index create], Post if user.role? :admin
        can %i[update destroy], Post, user: { role: 'user' }
        can %i[update destroy], Post, user_id: user.id
      end
    end
  end
end