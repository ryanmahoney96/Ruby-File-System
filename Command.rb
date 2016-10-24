

class Command

	#these are an easy way to make simple getters and setters in ruby
	#These ones hold the name of the parent directory of a file, the files name, and the description
	attr_accessor(:description)
	attr_accessor(:name_of_subject)
	attr_accessor(:parent_directory)

	def initialize
		self.description = "-This base class can print out its own name"
	end
	
	#using ruby's split function on the file path we can extract the parent directory and the file name itself
	def splitDirectory (nod)
		
		splitArray = File.split(nod)
		
		self.parent_directory = splitArray[0]
		self.name_of_subject = splitArray[1]
		
	end
	
	#do
	def execute
		puts "-Simple print of a Command \n"
	end
	
	def undo
		#nothing for now
	end
	
	#returns the full filepath of the original input
	def filePath
		return "#{parent_directory}/#{name_of_subject}"
	end

end