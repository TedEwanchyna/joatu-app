class UserPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end

  end

  def create?
    true
  end

  def update?
    user.is_admin? || user.id == scope.id
  end
end
