require 'bundler'
Bundler.require

require_relative './models/student'
require_relative './models/course'
require_relative './models/department'
require_relative './models/lecture'
require_relative './models/absence'
require_relative './models/exam'
require_relative './models/score'
require_relative './models/lectureseries'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{File.dirname(File.expand_path(__FILE__))}/development.sqlite")

class Thing
	include DataMapper::Resource
	property :id, Serial, :key => true
	property :created_at, DateTime
	property :title, String, :length => 255
	property :description, Text
end

DataMapper.finalize
DataMapper.auto_upgrade!
if Thing.count == 0
	Thing.create(:title => "Test Thing One", :description => "Sometimes I eat pizza.")
	Thing.create(:title => "Test Thing Two", :description => "Other times I eat cookies.")
end

get '/things/:id' do
	content_type :json
	@thing = Thing.get(params[:id].to_i)
	if @thing
		@thing.to_json
	else
		halt 404
	end
end


=begin
not_found do
	content_type :json
	halt 404, { error: 'URL not found' }.to_json
end
=end

get '/' do
	content_type :json
	"hello".to_json
end


get '/students/:srn/?' do
	content_type :json
	s = Student.get(params[:srn])
	if s!=nil
		s.to_json
	else
		{error: "Invalid/Non-existent SRN"}.to_json
	end
end

get '/students/marks/:srn/?' do
	content_type :json
	s = Student.get(params[:srn])
	if s!=nil
		s.score.to_json
	else
		{error: "Invalid/Non-existent SRN"}.to_json
	end
end
