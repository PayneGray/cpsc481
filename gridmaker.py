grid = ["-----x-x----x--------x----x----x---------------x-x---x------",
"-x---x-x----x-x------x----x----xxxxxxxxx--xxxxxx-x---x------",
"-x---x-x-x-xx-xxxxx--xx--xx----x-x--x-x--------x-x---x-x-xxx",
"-x---x--------x------x----x--xxx-x----x------x-x-x---x-x-x--",
"-x-----x----x-xxxx--xx----x----x----x--xxx--xx-x-x---x---x--",
"-x---x-x--xx--x----x------xxx--x-x--x-x------x-x-x---x-x----",
"-x-----x----x-x----x-x--xxx--x-x-------------x-x-x---x------",
"-x---x------x------x-x--x-x--x-x-x--x-x------x-x-----xxxx-x-",
"-----x-x----x-x-xx-x-x--x-x--x-xxxxxx-xxx-xxxx-x-----x------",
"xxxxxxxx-xxx-xx------x--x----x-x---x----x----x-x-xxx-x-x-x--",
"-x-x----x---x-xx-x-x-x-------x-----xx--xx----x-----x-x---x--",
"--------------x------x----x----x---x----x----x-x-----x-x----",
"---xx-x-------x----x----x-x----x---x--x-x--xx--x---x-x-xx--x",
"-x------x---x-x-x-xxxx-x-xxxx----------------x-x-----x-x----",
"-x-x----x---x-x------x----x----x------x------x-----x-xxx-xx-",
"xxxxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxx-xxxxx------",
"-x--x-x---x-x---x--x-----x---x----x--x-------------x-x------",
"-x--x-x---x-x---x--x-----x-----x-xx--------x-xxx-xxx-x-xx-xx",
"-x--x-x---x-x---x--x-x-xxx---x----------x----------x-x------",
"----x-----x-x---x--x-x---------------x--x--x-------x-x------",
"----x-x---x-x------x-x---x-xxxxxx-xxxxxxxxxxxxxxxxx--x------",
"-x--x-----x-x--------x---x-x----------x---x--x-x---x-xxx-x-x",
"-x--x-x---x-x---x--x-x------xxxxx-xx-xx---x--x-------x-x----",
"-xx-xxxx--x-x---x--x-x---x-x--------x-x--------x---x-x---x-x",
"----x-----x-x---x--x-x---x-x---x--xxx-----x--x-x---x-x-x----",
"--x-x-------x---x--------x-x--x-----x-x---x----x---x-x------",
"--x-xxx-x-x-x---x--x-----x-x--x-------x---x--xx----x-x-xxx-x",
"--x-x-----x-x-xxxxxxx-xxxx-xxx-xxx-xx-x---x-x--x---x-x------",
"--x-x-----x-x------------x----------x-x---x----x---x-xxxxx--",
"----xx-x-xx-xx-xxxxxx-xxxx-x--xxxx--x-----x-x--x---x--------",
"xx--x-----x-x------------x-x--------x-x--------x---x-x------",
"----x-----x-xxxxx-xxx-xxxx-x-----x----x---x-x--x---x-x------",
"x-x-x-----x-x---x--x-----xxxx-xxxxxxxxxxx-xxxxxxxxxx-xx-x-xx",
"----xxxx--x--------xx-x-xx--x-x------------------x-x-x----x-",
"----x-----x-x---x--x---x-x--x-x-------x---x------x-x-x----x-",
"-xx-------x-x------------x--x---xxxxx-----x-x-xxx--x-x--xxx-",
"----x--x--x-x---x------x-x------------x------------x-x----x-",
"--xx---x--------x--x-----x----x-------x---x------x-x-x--xxx-",
"----x--x--xxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxx------",
"----x--x--x-------------------------------------------------"]


print "(setf grida (make-array '(40 60)))"

for row in range(len(grid)):
	line = ""
	for column in range(len(grid[row])):
		if grid[row][column]=="x":
#			print "(setf (aref grida", row, column,") -1)"
			line += " -1"
		elif grid[row][column]=="-":
			line += " 0"
	print "("+line+")"