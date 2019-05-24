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
    record.user == current_user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
