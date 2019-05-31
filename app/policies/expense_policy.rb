class ExpensePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.group.users.include?(user)
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    record.group.users.include?(user)
  end

  def update?
    record.group.users.include?(user)
  end

  def destroy?
    record.group.users.include?(user)
  end
end
