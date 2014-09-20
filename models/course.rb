class Course
	include DataMapper::Resource
	property :id, Serial
	property :name, String, :required => true

	has n,:student, 'Student',
		:parent_key => [:id],
		:child_key => [:course_id],
		:required => true

	has n,:subject, 'Subject',
		:parent_key => [:id],
		:child_key => [:course_id]
		
	has n,:lectureseries, 'LectureSeries',
		:parent_key => [:id],
		:child_key => [:course_id]

end
