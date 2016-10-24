

require_relative "Command"

class RenameDirectoryCommand < Command

	attr_accessor(:newname)

	def initialize(on, nn)
				
		splitDirectory(on)	
				
		self.newname = nn
		self.description = "-Renaming the Directory: '#{name_of_subject}'"

	end

	#using the File.rename command we can rename a directory, as long as it doesn't already exist
	def execute
		
		if Dir.exist?(filePath)
			if Dir.exist?("#{parent_directory}/#{newname}")
				puts "-'#{newname}' already exists in this directory"
			else
				File.rename(filePath, "#{parent_directory}/#{newname}")
				puts "-'#{name_of_subject}' was renamed '#{newname}' \n"
			end
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end
	
	# we will rerename the directory to the original, so long as that name hasn't been taken already
	def undo
		if Dir.exist?("#{parent_directory}/#{newname}")
			if Dir.exist?(filePath)
				puts "-'#{name_of_subject}' already exists in this directory"
			else
				File.rename("#{parent_directory}/#{newname}", filePath)
				puts "-'#{newname}' was renamed '#{name_of_subject}' \n"
			end
		else
			puts "-'#{newname}' does not exist in this directory \n"
		end
	end

end



