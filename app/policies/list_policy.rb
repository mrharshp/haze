class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def edit?
    record.group.users
  end

  def update?
    edit?
  end

  def destroy?
    record.user == user
  end
end
