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
        grade_out = 'Class 1'
      elsif grade.include?('2')
        grade_out = 'Class 2'
      elsif grade.include?('3')
        grade_out = 'Class 3'
      elsif grade.include?('4')
        grade_out = 'Class 4'
      elsif grade.include?('5')
        grade_out = 'Class 5'
      elsif grade.include?('6')
        grade_out = 'Class 6'
      elsif grade.include?('7')
        grade_out = 'Class 7'
      elsif grade.include?('8')
        grade_out = 'Class 8'
      end
    end
    grade_out
  end
  
  def to_grade
    String.to_grade(self)
  end
end