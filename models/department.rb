class Department
	include DataMapper::Resource
	property :id, Serial
	property :name, String, :required => true
end
