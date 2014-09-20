class Enrollment
	include DataMapper::Resource
	belongs_to :lecture_series, 'Lecture_Series',
		:parent_key => [:id],
		:child_key => [:lecture_series_id],
		:required => true
	belongs_to :student, 'Student',
		:parent_key => [:srn],
		:child_key => [:srn],
		:required => true
end
