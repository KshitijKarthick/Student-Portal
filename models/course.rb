class Course
	include DataMapper::Resource
	property :id, Serial
	property :name, String, :required => true

	has n,:students, 'Student',
		:parent_key => [:id],
		:child_key => [:course_id]

	has n,:subjects, 'Subject',
		:parent_key => [:id],
		:child_key => [:course_id]
		
	has n,:lectureserieses, 'LectureSeries',
		:parent_key => [:id],
		:child_key => [:course_id]

end
