class ArticlePolicy < ApplicationPolicy

    def create?
      user.admin?
    end

    def new?
      user.admin?
    end

    def edit?
      user.admin?
    end

    def index?
      true
    end

    def update?
      user.admin?
    end

    def show?
      scope.where(:id => record.id).exists? && user == record.user
    end

    def destroy?
      scope.where(:id => record.id).exists? && user == record.user
    end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
