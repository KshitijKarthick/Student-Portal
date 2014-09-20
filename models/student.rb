class Student
	include DataMapper::Resource
	property :srn, String, :unique => true, :key => true, :required => true
	property :first_name, String, :required => true
	property :middle_name, String
	property :last_name, String
	property :phone_number, String, :required => true
	property :dob, Date, :required => true
	property :section, String, :required => true
	property :semester, Integer, :required => true
	belongs_to :course, 'Course',
		:parent_key => [:id],
		:child_key => [:course_id],
		:required => true
	has n,:absence, 'Absence',
		:parent_key => [:student_reg_number],
		:child_key => [:srn]
	has n,:score,'Score',
		:parent_key => [:student_reg_number],
		:child_key => [:srn]
	belongs_to :department, 'Department',
		:parent_key => [:id]
		:child_key => [:department_id]
		:required => true
end
