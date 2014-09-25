s1 = Student.new(:srn => '1ru353',:first_name =>"Raghav", :phone_number => "9988776655", :dob => Date.new(1994,7,2), :section => 'A', :semester => 2, :sex => 'm')
s2 = Student.new(:srn => '1ru123', :first_name =>"Ram", :phone_number => "9933445566", :dob => Date.new(1992,3,5), :section => 'B', :semester => 6, :sex => 'm')

c1 = Course.new(:name => 'BE')
c2 = Course.new(:name => 'MSc')

c1.students << s1
c2.students << s2

d = Department.new(:name => 'CSE')

d.students << s1
d.students << s2

s1.save
s2.save

