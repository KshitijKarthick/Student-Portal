class Score
	include DataMapper::Resource
	property :max_marks,Integer
	property :marks_obtained, String
	property :min_marks,Integer
	belongs_to :student, 'Student',
		:parent_key => [:srn],
		:child_key => [:srn],
		:required => true
	belongs_to :exam, 'Exam',
		:parent_key => [:id],
		:child_key => [:exam_id],
		:required => true
end
