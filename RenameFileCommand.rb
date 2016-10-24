

require_relative "Command"

class RenameFileCommand < Command

	attr_accessor(:newname)

	#takes in the old name of the file and its path, along with the new name
	def initialize(on, nn)
				
		splitDirectory(on)
		
		self.newname = nn
		self.description = "-Renaming the file: '#{name_of_subject}'"

	end

	#if it exists, we rename it
	def execute
		if File.exist?(filePath)
			File.rename(filePath, newname)
			puts "-'#{name_of_subject}' was renamed '#{newname}' \n"
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end
	
	#if the file exists, we rename it again
	def undo
		if File.exist?("#{parent_directory}/#{newname}")
			File.rename(newname, name_of_subject)
			puts "-'#{newname}' was renamed '#{name_of_subject}' \n"
		else
			puts "-'#{newname}' does not exist in this directory \n"
		end
	end

end



