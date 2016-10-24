

require_relative "Command"
require_relative "DeleteDirectoryCommand"


class CreateDirectoryCommand < Command

	#look up the join command in File
	attr_accessor(:content)

	def initialize(nod)
				
		splitDirectory(nod)
		
		self.description = "-Creating a Directory: '#{name_of_subject}'"

	end

	#use ruby's mkdir command to make a folder (directory)
	def execute
		if Dir.exist?(filePath)
			puts "-'#{name_of_subject}' already exists in this directory"
		else	
			Dir.mkdir(filePath)
			puts "-Directory '#{name_of_subject}' has been created in directory '#{parent_directory}' \n"
		end
	end
	
	#we delete the directory and whatever is in it
	def undo
		if Dir.exist?(filePath)
			recycle = DeleteDirectoryCommand.new(filePath)
			recycle.execute
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end

end