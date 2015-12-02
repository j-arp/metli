class CallToActionDecorator < Draper::Decorator
  delegate_all

  def chart
    html = []
    self.actions.each do | action |
      html << "<span class=\"bar-graph-container\"><span class=\"bar-graph\" style=\" width: #{action.percent_of_vote}%\"></span></span>"
      html << "<span class=\"bar-stats\">#{action.content}: #{action.votes.count} votes (#{action.percent_of_vote}%).</span>"
    end

    return "<ul>#{html.join(" ")}</ul>"
  end

end
