class WeeklyAttendance
  include DataMapper::Resource
  property :week_number, Integer, :required => true, :key => true
  property :classes_held, Integer
  property :classes_attended, Integer

  belongs_to :student, 'Student',
    :parent_key => [:srn],
    :child_key => [:srn],
    :required => true,
    :key => true

  belongs_to :lectureseries, 'LectureSeries',
    :parent_key => [:id],
    :child_key => [:lecture_series_id],
    :required => true,
    :key => true
end
