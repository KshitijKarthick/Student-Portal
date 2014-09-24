class Subject
	include DataMapper::Resource
	property :id, Serial
	property :code, String, :required => true
	property :name, String, :required => true
	property :semester, Integer, :required => true

	belongs_to :course, 'Course',
		:parent_key => [:id],
		:child_key => [:course_id],
		:required => true
		
	belongs_to :department, 'Department',
		:parent_key => [:id],
		:child_key => [:department_id],
		:required => true

	has n,:lectureserieses,'LectureSeries',
		:parent_key => [:id],
		:child_key => [:subject_id]
end
