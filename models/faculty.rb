class Faculty
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true
  property :phone_number, String
end
