require 'bundler'
Bundler.require
require_relative './dm_config'
require 'digest'


not_found do
	content_type :json
	halt 404, { success: 0, error_message: 'URL not found' }.to_json
end

get '/' do
	content_type :json
	"hello".to_json
end

def student_info(s)
	{   
		success: 1,
		srn: s.srn, 
		name: s.full_name, 
		dob: s.dob, 
		sex: s.sex,
		semester: s.semester,
		course: s.course.name,
		department: s.department.name
	}
end

def student_attendance_current_sem(s)
	aggregated_attendance = Array.new
	attendance=WeeklyAttendance.all(:student =>{:srn=>s.srn},:lectureseries=>{:subject=>{:semester=>s.semester}})
	
	attendance = attendance.group_by do |weekly_attendance|
		weekly_attendance.lecture_series_id
	end

	attendance.keys.each do |lecture_series_id|
		classes_attended = 0
		classes_held = 0
		
		attendance[lecture_series_id].each do |weekly_attendance|
			classes_attended+=weekly_attendance.classes_attended
			classes_held+=weekly_attendance.classes_held 
		end
		
		subject_name = attendance[lecture_series_id][0].lectureseries.subject.name
		percentage=(classes_attended.to_f/classes_held.to_f)*100
		aggregated_attendance.push(
				{
				classes_held: classes_held,
				classes_attended: classes_attended, 
				percentage: percentage.round, 
				subject_name: subject_name }
			)
	end

	return aggregated_attendance
end

def student_marks_current_sem(s)
	marks = Array.new
	p scores = Score.all(:student=>{:srn=>s.srn},:exam=>{:lectureseries=>{:subject=>{:semester=>s.semester}}})
	scores = scores.group_by do |score|
		score.exam.lectureseries.subject.name
	end
	scores.each do |subject_name,score_list|
		subject_marks = Array.new
		sum=0
		score_list.each do |score|
			sum+=score.marks_obtained.to_i
			subject_marks.push({
				exam_name: score.exam.name,
				min_marks: score.exam.min_marks,
				max_marks: score.exam.max_marks,
				marks_obtained: score.marks_obtained
				})
		end


		marks.push(
		{
			subject_name: subject_name,
			average: sum.to_f/subject_marks.length,
			scores: subject_marks			
			})
	end
	return marks
end



get '/students/:srn/info' do
	content_type :json
	s = Student.get(params[:srn].downcase)
	if s
	si=student_info(s)
	si["hash"]=	Digest::MD5.hexdigest(si.to_s)
	si.to_json
	else
		{ 
			success: 0,
			error_message: "Invalid/Non-existent SRN"
		}.to_json
	end
end

get '/students/:srn/hash' do
	content_type :json
	s = Student.get(params[:srn].downcase)
	if s
		{   
			success: 1,
			info_hash: Digest::MD5.hexdigest(student_info(s).to_s),
			marks_hash: Digest::MD5.hexdigest(student_marks_current_sem(s).to_s),
			attendance_hash: Digest::MD5.hexdigest(student_attendance_current_sem(s).to_s)
		}.to_json
	else
		{
			success: 0,
			error_message: "Invalid/Non-existent SRN"
		}.to_json
	end
end



get '/students/:srn/marks' do
	content_type :json
	s = Student.get(params[:srn])
	if s
		marks = student_marks_current_sem(s)
		hash = Digest::MD5.hexdigest(marks.to_s)
		{
			success: 1,
			hash: hash,
			data: marks
		}.to_json
	else
		{
			success: 0,
			error_message: "Invalid/Non-existent SRN"
		}.to_json
	end
end

				

get '/students/:srn/attendance' do
	content_type :json
	s = Student.get(params[:srn])
	if s
		aggregated_attendance = student_attendance_current_sem(s)
		hash = Digest::MD5.hexdigest(aggregated_attendance.to_s)
		{
			success: 1,
			hash: hash,
			data: aggregated_attendance
		}.to_json
	else
		{
			success: 0,
			error_message: "Invalid/Non-existent SRN"
		}.to_json
	end
end

				
get '/students/login' do
	content_type :json
	s = Student.get(params[:uname].downcase)
	if s
		dob = s.dob.day.to_s.rjust(2,'0') + s.dob.month.to_s.rjust(2,'0') + s.dob.year.to_s
	end
	if dob == params[:pwd]
		return {success: 1}.to_json
	else
		return {success: 0, error_message: "The SRN does not exist  or wrong password"}.to_json
	end
end