class Subject
	include DataMapper::Resource
	property :id, Serial
	property :code, String, :required => true
	property :name, String, :required => true
	propery :semester, Integer, :required => true

	belongs_to :course, 'Course',
		:parent_key => [:id],
		:child_key => [:course_id],
		:required => true
	belongs_to :department, 'Department',
		:parent_key => [:id],
		:child_key => [:department_id],
		:required => true
end
