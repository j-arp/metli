class CallToActionDecorator < Draper::Decorator
  delegate_all

  def chart
    html = []
    self.actions.each do | action |
      html << "<li>#{action.content}: #{action.votes.count} votes.</li>"
    end

    return "<ul>#{html.join(" ")}</ul>"
  end

end
