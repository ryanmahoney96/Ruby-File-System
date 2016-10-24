
require_relative "Command"
require "FileUtils"


class MoveDirectoryCommand < Command

	attr_accessor(:new_dir)

	def initialize(cd, nd)
		
		splitDirectory(cd)
				
		self.new_dir = nd
		self.description = "-Moving the Directory: '#{name_of_subject}'"

	end

	#using the FileUtils.mv command included with FileUtils, we can move a directory and all its contents
	def execute
		if Dir.exist?(filePath)
			if Dir.exist?(new_dir)
					if Dir.exist?("#{new_dir}/#{name_of_subject}")
						puts "-The Directory '#{name_of_subject}' already exists in '#{new_dir}'"
					else	
						FileUtils.mv(filePath, new_dir)
						puts "-'#{name_of_subject}' was moved to '#{new_dir}' \n"
					end
			else
				puts "-There is no directory '#{new_dir}' on the file system \n"
			end
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end
	
	def undo
		if Dir.exist?("#{new_dir}/#{name_of_subject}")
			if Dir.exist?(parent_directory)
					if Dir.exist?(filePath)
						puts "-The Directory '#{name_of_subject}' already exists in '#{parent_directory}'"
					else	
						FileUtils.mv("#{new_dir}/#{name_of_subject}", parent_directory)
						puts "-'#{name_of_subject}' was moved back to '#{parent_directory}' \n"
					end
			else
				puts "-There is no directory '#{parent_directory}' on the file system \n"
			end
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end

end



