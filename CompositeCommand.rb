

require_relative "Command"
require_relative "CreateFileCommand"
require_relative "RenameFileCommand"
require_relative "MoveFileCommand"
require_relative "DeleteFileCommand"
require_relative "CreateDirectoryCommand"
require_relative "RenameDirectoryCommand"
require_relative "MoveDirectoryCommand"
require_relative "DeleteDirectoryCommand"

# We will also use the 'Composite Pattern' to group commands together. A 'Composite' command has the same methods as a command (do(), undo(), description()) but also has a method called addCommand() which will store a command on a list. When do() is called on a composite command all of the commands on the list will have do() called on them. When undo() is called the commands will be undone.
# In addition, add two methods to step forward or backward some number of commands at a time.
	# beginning_path = "C:/path/to/a/dir"
#create a composite command (a group of ordered commands)
	# cc = CompositeCommand.new
#add some commands to the group
	# cc.addCommand(CreateDirectoryCommand.new(beginning_path + "/new_dir"))
	# cc.addCommand(CreateFileCommand.new(beginning_path + "/new_dir/new_file.txt", "Hello World!!!"))
	# cc.addCommand(CreateDirectoryCommand.new(beginning_path + "/another_dir"))
	# cc.addCommand(MoveFileCommand.new(beginning_path + "/new_dir/new_file.txt", beginning_path + "/another_dir/new_file.txt"))
	# cc.addCommand(DeleteFileCommand.new(beginning_path + "/new_dir/new_file.txt"))
#print the description of all of the commands
	# puts cc.description();
#execute all of the commands in order
	# cc.do()
#undo all of the commands to get back to the beginning state
	# cc.undo()
#move forward two steps
	# cc.stepForward(2)
# #take a step back
	# cc.stepBackWard(1)
# #move forward three more steps
	# cc.stepForward(3)

class CompositeCommand < Command

	attr_accessor(:indexOfExecution)
	attr_accessor(:lastStep)
	
	attr_accessor(:doCommandList)
	attr_accessor(:undoCommandList)

	def initialize
		
		self.lastStep = true
		self.indexOfExecution = 0
		self.doCommandList = []
		self.undoCommandList = []

	end

	#we can add the new command to the back of our array of commands and the front of the array of undo commands, to preserve the correct order when iterating through
	def addCommand(commandItem)
		doCommandList << commandItem
		undoCommandList.unshift(commandItem)
	end
	
	#we execute in a FIFO order
	def execute
		doCommandList.each do |commandItem|
			commandItem.execute
		end
	end
	
	#we undo in a LILO order, so we can reverse the effects of execution
	def undo
		undoCommandList.each do |commandItem|
			commandItem.undo
		end
	end
	
	#we print the description of each command in particular
	def description
		doCommandList.each do |commandItem|
			puts commandItem.description
		end
	end
	
	#we can step forward a particular number of steps in our list
	def stepForward(numForward)
		
		i = 0
		
		#if the last step was forward, we continue stepping forward. But if it was backaward we must account for a numerical issue made when iterating by adding one
		if !(@lastStep)
			@indexOfExecution += 1
		end
		
		#continue to step forward until we reach the limit. We execute the command in the list and increment our iterators
		if checkSteps(numForward, true)

			while i < numForward do 
				doCommandList[@indexOfExecution].execute
				@indexOfExecution += 1
				i += 1	
			end
			
			@lastStep = true
			
		else
			@lastStep = false
			@indexOfExecution -= 1
		end
	end
	
	
	def stepBackward(numBackward)
		
		i = 0
		
		#if this is true, the last step we took was forward, and we must account for a similar numerical problem caused by it
		if @lastStep
			@indexOfExecution -= 1
		end	
		
		if checkSteps(numBackward, false)

			while i < numBackward do 
				doCommandList[@indexOfExecution].undo
				@indexOfExecution -= 1
				i += 1			
			end	
			
			@lastStep = false
		else
			@lastStep = true
			@indexOfExecution += 1
		end
		
	end
	
	#as long as we are within the bounds of our list of commands, we may proceed
	def checkSteps(numSteps, direction)
		goodToGo = true
		if (@indexOfExecution + numSteps) > doCommandList.length && direction
			puts "-There was an error stepping forward"
			goodToGo = false
		elsif (@indexOfExecution - numSteps) < 0 && !direction
			puts "-There was an error stepping backward"
			goodToGo = false
		end
		
		return goodToGo
	end
	
end





