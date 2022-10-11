module ApplicationHelper
  def inclination(count)
    return "вопросов" if (count % 100).between?(11, 14)
    case count % 10
    when 1 then "вопрос"
    when 2..4 then "вопроса"
    else
      "вопросов"
    end
  end
end
