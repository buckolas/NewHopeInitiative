module KiberaChildrenHelper
  def age(child)
    now = Date.today
    age = now.year - child.birth_date.year
    age -= 1 if (child.birth_date.month > now.month || (child.birth_date.month >= now.month && child.birth_date.day > now.day))
    age
  end
end
