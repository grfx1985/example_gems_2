class ArticleDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:

  def owned_by_user
    object.user.email
  end

  def created_at
    helpers.content_tag :span, class: 'time' do
      object.created_at.strftime("%a %m/%d/%y")
    end
  end

  def emphatic
    h.content_tag(:strong, "Awesome decorator")
  end

  def updated_at
    object.updated_at.strftime("%A, %B %e")
  end

  def moderation_status
    if moderated?
      "Moderated at #{updated_at}"
    else
      "Not moderated yet"
    end
  end
end
