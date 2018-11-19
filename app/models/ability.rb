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
      can %i[show index create], Post if user.role? :admin
      can %i[edit delete], Post if user.role? user_id: user.id
    end
  end
end
end