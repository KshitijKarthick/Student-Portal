require 'bundler'
Bundler.require
require_relative './dm_config'

not_found do
	content_type :json
	halt 404, { error: 'URL not found' }.to_json
end

get '/' do
	content_type :json
	"hello".to_json
end


get '/students/:srn' do
	content_type :json
	@s = Student.get(params[:srn])
	if @s
		{   
			srn: @s.srn, 
			name: @s.full_name, 
			dob: @s.dob, 
			semester: @s.semester,
			course: @s.course.name,
			department: @s.department.name,
		}.to_json
	else
		{
			error: "Invalid/Non-existent SRN"
		}.to_json
	end
end

get '/students/marks/:srn' do
	content_type :json
	@s = Student.get(params[:srn])
	if @s
		@s.score.to_json
	else
		{error: "Invalid/Non-existent SRN"}.to_json
	end
end
