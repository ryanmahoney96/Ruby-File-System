


require_relative "Command"
require_relative "CreateFileCommand"
require_relative "CreateDirectoryCommand"
require_relative "MoveDirectoryCommand"

# class DeleteDirectoryCommand < Command

	# attr_accessor(:directoryNames)
	# attr_accessor(:fileNames)
	# attr_accessor(:fileHash)
	
	# def initialize(nod)
				
		# splitDirectory(nod)
		
		# self.description = "Deleting the directory: '#{name_of_subject}'"

	# end

	
	# def execute
		
		# if Dir.exist?(filePath)
			
			# Dir.foreach(filePath) do |underling|
				# collectDirectoryData(underling)
			# end
			# Dir.rmdir(filePath)
			# puts "'#{name_of_subject}' was deleted \n"
		# else
			# puts "'#{name_of_subject}' does not exist in this directory \n"
		# end
	# end
	
	# def collectDirectoryData (directoryOrFileName)
		# if Dir.exist?(directoryOrFileName)
			# Dir.foreach(directoryOrFileName) do |underling|
				# collectDirectoryData(underling)
				# directoryNames << directoryOrFileName
			# end
		# elsif File.exist?(directoryOrFileName)
			# fileContent = File.read(directoryOrFileName)
			# self.filenames << directoryOrFileName
			# self.fileHash[directoryOrFileName] = fileContent
		# else
			# puts "Cannot read the file/directory"
		# end
	# end
	
	# def undo
		# reconstruct = CreateDirectoryCommand.new(parent_directory, name_of_subject)
		# reconstruct.execute
		
		# directoryNames.each do |subName|
			# subDirectory = CreateDirectoryCommand.new(filePath, subName)
		# end
		
		# fileNames.each do |fileName|
			# subFile = CreateFileCommand.new("#{filePath}/#{fileName}", fileHash[fileName])
		# end
		
	# end

# end

class DeleteDirectoryCommand < Command
	
	attr_accessor(:recycle)
	attr_accessor(:putInBin)
	
	def initialize(nod)
				
		splitDirectory(nod)
		
		self.recycle = CreateDirectoryCommand.new(parent_directory + "/The Recycle Bin")
		self.putInBin = MoveDirectoryCommand.new(filePath, "The Recycle Bin")

		
		self.description = "-Deleting the directory: '#{name_of_subject}'"

	end

	#here we discard the directory and its files into a recycle bin
	def execute
		
		if Dir.exist?(filePath)
			
			self.recycle.execute
			self.putInBin.execute
			
		else
			puts "-'#{name_of_subject}' does not exist in this directory \n"
		end
	end
	
	#if we want the files back we move them back to the directory where we got them
	def undo
		self.putInBin.undo
	end

end







