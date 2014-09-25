class Exam
	include DataMapper::Resource
	property :id, Serial
	property :date, Date, :required => true
	property :type, String, :required => true
	property :min_marks,Integer, :required => true
	property :max_marks,Integer, :required => true
	property :name, String, :required => true

	belongs_to :lectureseries, 'LectureSeries',
		:parent_key => [:id],
		:child_key => [:lecture_series_id],
		:required => true
		
	has n,:scores, 'Score',
		:parent_key => [:id],
		:child_key => [:exam_id]
end
