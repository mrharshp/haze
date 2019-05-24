class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def show?
      true
    end

    def create?
      true
    end

    def edit?
      record.user == user
    end

    def update?
      edit?
    end

    def destroy?
      edit?
    end
  end
end
