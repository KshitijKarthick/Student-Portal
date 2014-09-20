class Department
	include DataMapper::Resource
	property :id, Serial
	property :name, String, :required => true

	has n,:student, 'Student',
	:parent_key => [:id],
	:child_key => [:department_id],
	:required => true

	has n,:subject, 'Subject',
	:parent_key => [:id],
	:child_key => [:department_id]

	has n,:lectureseries, 'LectureSeries',
		:parent_key => [:id],
		:child_key => [:department_id]
end
