class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    if user.person.present? && user.person.is_caregiver?
      caregivers_abilities
    end
  end

  def caregivers_abilities
    can :manage, StoryTheme
    can :manage, StoryContext
    can :manage, Group
    can :manage, Story
    can :manage, StoryFragment
    can :manage, Caregiver
  end
end
