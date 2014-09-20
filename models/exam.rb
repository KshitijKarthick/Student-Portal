class Exam
	include DataMapper::Resource
	property :id, Serial
	property :date, Date
	property :type, String
	belongs_to :lectureseries, 'LectureSeries',
		:parent_key => [:id],
		:child_key => [:lecture_series_id],
		:required => true
	has n,:score, 'Score',
		:parent_key => [:id],
		:child_key => [:exam_id]
end