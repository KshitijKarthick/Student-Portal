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

	has n,:score,'Score',
		:parent_key => [:srn],
		:child_key => [:srn],
		:constraint => :protect

	has n,:weeklyattendance,"WeeklyAttendance",
		:parent_key => [:srn],
		:child_key => [:srn],
		:constraint => :protect

	belongs_to :department, 'Department',
		:parent_key => [:id],
		:child_key => [:department_id],
		:required => true

	def full_name
		return self[:first_name] + " " + self[:middle_name] + " " + self[:last_name]
	end

end
