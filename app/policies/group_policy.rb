class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.joins(:group_memberships).merge(GroupMembership.where(user: user))
    end
  end

  def show?
    record.users.include?(user)
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    record.users.include?(user)
  end

  def invite?
    record.users.include?(user)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
