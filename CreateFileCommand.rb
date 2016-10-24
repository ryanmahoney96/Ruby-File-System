

require_relative "Command"


class CreateFileCommand < Command

	attr_accessor(:content)

	#takes the name of directory and the content of the file
	def initialize(nod, c)
				
		splitDirectory(nod)
		
		self.content = c
		self.description = "-Creating a file: '#{name_of_subject}'"

	end

	#if the file already exists, we do not make another. Otherwise we will write a new file with the given content
	def execute
		if File.exist?(filePath)
			puts "-#{name_of_subject} already exists in this directory"
		else
			File.open(filePath, "w+") do |n|
				n.write(content)
			end
			puts "-File '#{name_of_subject}' has been created in directory '#{parent_directory}' \n"
		end
	end
	
	#if the file exists we will delete it, otherwise we spit out an error message
	def undo
		if File.exist?(filePath)
			File.delete(filePath)
			puts "-'#{name_of_subject}' was deleted \n"
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end

end



