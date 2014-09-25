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
	property :sex, String, :length => 1,:required => true

	belongs_to :course, 'Course',
		:parent_key => [:id],
		:child_key => [:course_id],
		:required => true

	has n,:scores,'Score',
		:parent_key => [:srn],
		:child_key => [:srn],
		:constraint => :protect

	has n,:weeklyattendances,"WeeklyAttendance",
		:parent_key => [:srn],
		:child_key => [:srn],
		:constraint => :protect

	belongs_to :department, 'Department',
		:parent_key => [:id],
		:child_key => [:department_id],
		:required => true

	def full_name 
		fname = self[:first_name]
		if self[:middle_name]
			fname += " " + self[:middle_name] 
		end
		if self[:last_name]
			fname+= " " + self[:last_name]
		end
		return fname
	end

end
