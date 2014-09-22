require 'bundler'
Bundler.require
require_relative './dm_config'




not_found do
	content_type :json
	halt 404, { success: 0, error_message: 'URL not found' }.to_json
end

get '/' do
	content_type :json
	"hello".to_json
end


get '/students/:srn/info' do
	content_type :json
	@s = Student.get(params[:srn])
	if @s
		{   
			success: 1,
			srn: @s.srn, 
			name: @s.full_name, 
			dob: @s.dob, 
			semester: @s.semester,
			course: @s.course.name,
			department: @s.department.name,
		}.to_json
	else
		{ 
		 	success: 0,
			error_message: "Invalid/Non-existent SRN"
		}.to_json
	end
end

get '/students/:srn/marks/' do
	content_type :json
	@s = Student.get(params[:srn])
	if @s
		@s.score.to_json
	else
		{
			success: 0,
			error_message: "Invalid/Non-existant SRN"
		}.to_json
	end
end
