class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can %i[update destroy], Recipe, user_id: user.id
  end
end
