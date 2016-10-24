


require_relative "Command"
require_relative "CreateFileCommand"


class DeleteFileCommand < Command

	attr_accessor(:fileContent)

	def initialize(nod)
				
		splitDirectory(nod)
		
		self.description = "-Deleting the file: '#{name_of_subject}'"

	end

	#we collect the data in the file through a read just in case we want it back
	def execute
		
		if File.exist?(filePath)
			fileContent = File.read(filePath)
			File.delete(filePath)
			puts "-'#{name_of_subject}' was deleted \n"
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end
	
	#we recollect the data and recreate the file
	def undo
		remake = CreateFileCommand.new(filePath, fileContent)
		remake.execute
	end

end