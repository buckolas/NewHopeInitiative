class String
  def self.to_bool(val)
    return true if val && (val == true || val =~ (/^(true|t|yes|y|1)/i))
    return false
  end
  
  def to_bool
    String.to_bool(self)
  end
  
  def self.to_gender(gender)
    return 'Female' if gender && gender =~ (/^(female|f)/i)
    return 'Male'
  end
  
  def to_gender
    String.to_gender(self)
  end
  
  def self.to_grade(grade)
    grade_out = 'Pre-Unit'
    if grade
      if grade.include?('1')
        grade_out = '1'
      elsif grade.include?('2')
        grade_out = '2'
      elsif grade.include?('3')
        grade_out = '3'
      elsif grade.include?('4')
        grade_out = '4'
      elsif grade.include?('5')
        grade_out = '5'
      elsif grade.include?('6')
        grade_out = '6'
      elsif grade.include?('7')
        grade_out = '7'
      elsif grade.include?('8')
        grade_out = '8'
      end
    end
    grade_out
  end
  
  def to_grade
    String.to_grade(self)
  end
  
  def self.to_sleeping_location(loc)
    return 'Floor' if loc && loc =~ (/^(floor|f)/i)
    return 'Bed'
  end
  
  def to_sleeping_location
    String.to_sleeping_location(self)
  end
  
  def self.to_orphan(orphan)
    return 'Single' if orphan && orphan =~ (/^(single|s|1)/i)
    return 'Double' if orphan && orphan =~ (/^(double|d|2)/i)
    return 'Not Applicable'
  end
  
  def to_orphan
    String.to_orphan(self)
  end
end