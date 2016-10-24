
require_relative "Command"
require_relative "CreateFileCommand"


class MoveFileCommand < Command

	attr_accessor(:new_dir)
	attr_accessor(:fileContent)

	#we get the current file and path and the place we want to move it
	def initialize(cd, nd)
		
		splitDirectory(cd)
		
		self.new_dir = nd
		self.description = "-Moving the file: '#{name_of_subject}'"

	end

	#if the file exists and there isnt already a file by that name in the new directory, we make another and delete the 'old' one
	def execute
		if File.exist?(filePath)
			if Dir.exist?(new_dir)
					if File.exist?("#{new_dir}/#{name_of_subject}")
						puts "-The file #{name_of_subject} already exists in #{new_dir}"
					else	
						fileContent = File.read(filePath)
						newFile = CreateFileCommand.new("#{new_dir}/#{name_of_subject}", fileContent)
						newFile.execute
						File.delete(filePath)
						puts "-'#{name_of_subject}' was moved to '#{new_dir}' \n"
					end
			else
				puts "-There is no directory #{new_dir} on the file system \n"
			end
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end
	
	#reverse execute
	def undo
		if File.exist?("#{new_dir}/#{name_of_subject}")
			if Dir.exist?(parent_directory)
				if File.exist?(filePath)
						puts "-The file #{name_of_subject} already exists in #{parent_directory}"
				else	
					fileContent = File.read("#{new_dir}/#{name_of_subject}")
					newFile = CreateFileCommand.new(filePath, fileContent)
					newFile.execute
					File.delete("#{new_dir}/#{name_of_subject}")
					puts "-'#{name_of_subject}' was moved back to '#{parent_directory}'\n"
				end
			else
				puts "-There is no directory #{parent_directory} on the file system \n"
			end
		else
			puts "-#{name_of_subject} does not exist in this directory \n"
		end
	end

end



