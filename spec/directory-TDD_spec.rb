require 'directory-TDD'

describe 'student directory' do

		before(:each) do
			allow(self).to receive(:puts)
		end

	context 'prints out required text' do 
		it 'prints header' do
			header = "The students of my cohort at Makers Academy\n============"
			expect(self).to receive(:puts).with(header)
			print_header
		end
		
		it 'prints out a request for student name ' do
			str = "Please enter the names of the students\nTo finish, just hit return twice"
			expect(self).to receive(:puts).with(str)
			print_req_for_student_name
		end

		it 'prints out the footer with 1 student when there is 1 student' do
			footer = "Overall we have 1 great student"
			update_student_array("Nicola", "June", "UK")
			expect(self).to receive(:puts).with(footer)
			print_footer
		end	

		it 'prints out the footer with n students when there are n students' do
			update_student_array("Nicola", "June", "UK")
			update_student_array("Jeremy", "June", "UK")
			footer = "Overall we have 2 great students"
			expect(self).to receive(:puts).with(footer)
			print_footer
		end
		
		it 'prints out n students in the array after n students are inputted' do
			expect(self).to receive(:puts).with("Now we have 1 great student")
			expect(self).to receive(:puts).with("Now we have 2 great students")
			update_student_array("Nicola", "June", "UK")
			update_student_array("Jeremy", "June", "UK")	
		end	


		it 'prints out a list of all students information' do
			update_student_array("Jeremy", "june", "UK")
			update_student_array("Nicola", "june", "UK")
			expect(self).to receive(:puts).with("Jeremy (june cohort) from UK"),("Nicola (june cohort) from UK")
			#expect(self).to receive(:puts).with("Nicola (june cohort)")
			print_students	
		end	

		it 'prints the exit statement' do
			expect(self).to receive(:print_header)
			expect(self).to receive(:print_students)
			expect(self).to receive(:print_footer)
			print_on_exit
		end
	end

	context 'Getting user inputs' do
		it 'takes a user input of students' do
				student_name ="Jeremy\n"
				expect(self).to receive(:gets).and_return(student_name)
				expect(take_user_input).to eq "Jeremy"
		end
		

	it 'asks for a cohort' do
			expect(self).to receive(:puts).with("Please enter the student's cohort")
			ask_for_cohort
	end

	it 'asks the user to input a nationality' do
			expect(self).to receive(:puts).with("Please enter the student's nationality")
			ask_for_nationality
	end

	it 'continues to ask for user input if names are entered' do
			student_name = "Jeremy"
			cohort = "June"
			nationality = "UK"
			expect(self).to receive(:gets).and_return(student_name, cohort, nationality, "")

			expect(self).to receive(:puts).with("Please enter the names of the students\nTo finish, just hit return twice")
			input_students
	end

		it 'ends student input if user hit return twice' do
			student_name = ""
			expect(self).to receive(:gets).and_return(student_name)
			expect(self).to receive(:puts).with("Overall we have 0 great student")
			input_students
		end

	end
	
	context 'Saving user inputs'	do
		
		it 'when a student\'s details are inputted, saves it to the student hash' do
			expect(self).to receive(:take_user_input).and_return("Jeremy", "June", "UK", "")
			input_students
			expect(students.include?({:name => "Jeremy", :cohort => "June", :nationality => "UK"})).to be true
		end

		it 'when a cohort is not inputted, makes the default cohort June' do
			expect(self).to receive(:take_user_input).and_return("Annabel", "", "UK", "")
			input_students
			expect(students.include?({:name => "Annabel", :cohort => "june", :nationality => "UK"})).to be true
		end

	
		it 'saves the student hash into the student array' do
					student_name = "Jeremy"
					cohort = :may
					nationality = "UK"
					update_student_array(student_name, cohort, nationality)
					expect(students.include?({:name => student_name, cohort: cohort, nationality: nationality})).to be true
			end
		
	end
	

	context 'counts the number of students in the array' do
		it 'count array' do
			update_student_array("Nicola", "June", "UK")
			expect(count_students).to eq(1)
		end

		it 'can return the number of students when one is added' do
			update_student_array("Nicola", "June", "UK")
			update_student_array("Jeremy", "June", "UK")
			expect(count_students).to eq(2)
		end
	end
end
