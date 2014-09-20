class LectureSeries
	include DataMapper::Resource
	property :id, Serial
	property :year, Date
	belongs_to :course, 'Course',
		:parent_key => [:id],
		:child_key => [:course_id],
		:required => true
	has n, :exam, 'Exam',
		:parent_key => [:id],
		:child_key => [:lecture_series_id]
	has n, :lecture, 'Lecture',
		:parent_key => [:id],
		:child_key => [:lecture_series_id]
	belongs_to :department, 'Department',
		:parent_key => [:id]
		:child_key => [:course_id]
		:required => true
	belongs_to :faculty, 'Faculty',
		:parent_key => [:id]
		:child_key => [:faculty_id]
		:required => true
	belongs_to :subject, 'Subject',
		:parent_key => [:id]
		:child_key => [:subject_id]
		:required => true
end