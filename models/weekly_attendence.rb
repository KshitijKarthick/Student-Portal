class Weekly_Attendence
  include DataMapper::Resource
  property :week_number, Integer, :required => true
  property :classes_held, Integer
  property :classes_attended, Integer

  belongs_to :student, 'Student',
    :parent_key => [:srn],
    :child_key => [:srn],
    :required => true
  belongs_to :lecture_series, 'Lecture_Series',
    :parent_key => [:id],
    :child_key => [:lecture_series_id],
    :required => true
end
