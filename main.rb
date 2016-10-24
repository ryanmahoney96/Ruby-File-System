


# Write an OO program in ruby that allows the user to execute file system commands. The user should be able to issue file commands:

# create a file
# rename a file
# move a file
# delete a file

# and directory commands:

# create a directory
# rename a directory
# move a directory
# delete a directory

# Ruby has a couple of built in classes called File and Dir that will be useful for manipulating the file system.

# In order to accomplish this we will use the 'Command Pattern' which is a way to group commands together so that they can be executed in batches. Every command object has a description and the methods do() and undo(). The undo() method performs the inverse of the do() method.

# #create a new file command at a certain path with the given text 
# #no file is actually created in this step- we are just creating the command
# c = CreateFileCommand.new("C:/path/to/a/dir/file.txt", "Hello World!!!")

# #print the description of the command
# puts c.description(); #prints "Creating a file: C:/path/to/a/dir/file.txt"

# #execute the command by calling do(), a new file should be created with the passed in text
# c.do()

# #undo the command by deleting the file (every file and directory operation has an inverse)
# c.undo()

# We will also use the 'Composite Pattern' to group commands together. A 'Composite' command has the same methods as a command (do(), undo(), description()) but also has a method called addCommand() which will store a command on a list. When do() is called on a composite command all of the commands on the list will have do() called on them. When undo() is called the commands will be undone.

# In addition, add two methods to step forward or backward some number of commands at a time.

# beginning_path = "C:/path/to/a/dir"

# #create a composite command (a group of ordered commands)
# cc = CompositeCommand.new

# #add some commands to the group
# cc.addCommand(CreateDirectoryCommand.new(beginning_path + "/new_dir"))
# cc.addCommand(CreateFileCommand.new(beginning_path + "/new_dir/new_file.txt", "Hello World!!!"))
# cc.addCommand(CreateDirectoryCommand.new(beginning_path + "/another_dir"))
# cc.addCommand(MoveFileCommand.new(beginning_path + "/new_dir/new_file.txt", beginning_path + "/another_dir/new_file.txt"))
# cc.addCommand(DeleteFileCommand.new(beginning_path + "/new_dir/new_file.txt"))

# #print the description of all of the commands
# puts cc.description();

# #execute all of the commands in order
# cc.do()

# #undo all of the commands to get back to the beginning state
# cc.undo()

# #move forward two steps
# cc.stepForward(2)

# #take a step back
# cc.stepBackWard(1)

# #move forward three more steps
# cc.stepForward(3)

# Finally, write unit tests to test all of the functionality. I will grade the assignment by running your tests. 

# Make the path to your files and directories be relative to a location so that your code will run on my machine without me having to update any path strings. In other words, make the beginning of all your test paths start with a period. For example, "./path/to/a/dir" will look in the current working directory (where the program is being run from) because of the period.

require_relative "Command"
require_relative "CreateFileCommand"
require_relative "RenameFileCommand"
require_relative "MoveFileCommand"
require_relative "DeleteFileCommand"
require_relative "CreateDirectoryCommand"
require_relative "RenameDirectoryCommand"
require_relative "MoveDirectoryCommand"
require_relative "DeleteDirectoryCommand"
require_relative "CompositeCommand"

require "FileUtils"

require 'test/unit/assertions'
extend Test::Unit::Assertions

beginning_path = "./"

# first = Command.new
# puts first.description
# first.execute
# first.undo

# puts

#!!!Taking out commented sections will interfere with proceeding function calls and may result in execution faltering!!!#

#we create a file and assert that the file exists
createFile = CreateFileCommand.new(beginning_path + "sample.txt", "Nothing")
puts createFile.description
createFile.execute
assert(File.exist?(beginning_path + "sample.txt"))
#createFile.undo

puts

#we rename sample.txt, assert that that newly named file exists, then re-rename it sample.txt
renameFile = RenameFileCommand.new(beginning_path + "sample.txt", "Nothing.txt")
puts renameFile.description
renameFile.execute
assert(File.exist?(beginning_path + "Nothing.txt"))

renameFile.undo

puts

#here we are creating a directory and asserting that it exists
createTestDir = CreateDirectoryCommand.new(beginning_path + "testDir")
puts createTestDir.description
createTestDir.execute
assert(Dir.exist?(beginning_path + "testDir"))

#here we are moving the file to a new location (the directory above), asserting it is there, and then moving it back
moveFile = MoveFileCommand.new(beginning_path + "sample.txt", beginning_path + "testDir")
puts moveFile.description
moveFile.execute
assert(File.exist?(beginning_path + "testDir/" + "sample.txt"))

moveFile.undo

puts

#here we delete the file, assert that it no longer exists, then we recreate it where it was
deleteFile = DeleteFileCommand.new(beginning_path + "sample.txt")
puts deleteFile.description
deleteFile.execute
assert(!File.exist?(beginning_path + "sample.txt"))

deleteFile.undo

puts

#creating another directory, deleting it and asserting that it is gone (at the bottom), then remaking it
createDir = CreateDirectoryCommand.new(beginning_path + "sample")
puts createDir.description
createDir.execute

puts

#we rename the directory, assert that it has been renamed, then re-rename
renameDir = RenameDirectoryCommand.new(beginning_path + "sample", "renamedSample")
puts renameDir.description
renameDir.execute
assert(Dir.exist?(beginning_path + "renamedSample"))

renameDir.undo

puts

#create a directory
destMaker = CreateDirectoryCommand.new(beginning_path + "Dest")
puts destMaker.description
destMaker.execute

puts

#moving a directory into that directory, asserting that it is where it is, then bringing it back
moveDir = MoveDirectoryCommand.new(beginning_path + "sample", beginning_path + "Dest")
puts moveDir.description
moveDir.execute
assert(Dir.exist?(beginning_path + "Dest/sample"))

moveDir.undo

puts

#delete a directory, assert that it is gone, then bring it back
deleteDir = DeleteDirectoryCommand.new(beginning_path + "testDir")
puts deleteDir.description
deleteDir.execute
assert(!Dir.exist?(beginning_path + "testDir"))

deleteDir.undo

puts

#creating a new composite command, starts with no commands so it is useless
cc = CompositeCommand.new

#add some commands to the group to make the cc more functional and complicated
cc.addCommand(CreateDirectoryCommand.new(beginning_path + "new_dir"))
cc.addCommand(CreateFileCommand.new(beginning_path + "new_dir/new_file.txt", "Hello World!!!"))
cc.addCommand(CreateDirectoryCommand.new(beginning_path + "another_dir"))
cc.addCommand(MoveFileCommand.new(beginning_path + "new_dir/new_file.txt", beginning_path + "another_dir/"))
cc.addCommand(DeleteFileCommand.new(beginning_path + "new_dir/new_file.txt"))

#print the description of all of the commands in order of insertion
cc.description

#execute all of the commands in order of insertion
cc.execute

puts

#undo all of the commands in order to recreate the start state
cc.undo

#move forward two steps in the command list
#putting in more steps than there are commands will result in an error message and no steps being taken
cc.stepForward(2)
puts

#take a step back, done in the reverse order so that the last step forward is the the first step undone

cc.stepBackward(1)
puts

#move forward three more steps
cc.stepForward(4)

cc.stepBackward(2)
puts

cc.stepForward(4)
puts

cc.stepBackward(2)
puts


createFile.undo
createTestDir.undo
createDir.undo
assert(!Dir.exist?(beginning_path + "sample"))

destMaker.undo



FileUtils.remove_dir(beginning_path + "The Recycle Bin", true)
puts "The Recycle Bin was Emptied"





