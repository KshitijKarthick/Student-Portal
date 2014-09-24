class Faculty
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true
  property :phone_number, String

  has n,:lectureserieses,'LectureSeries',
  	:parent_key => [:id],
  	:child_key => [:faculty_id]
end
