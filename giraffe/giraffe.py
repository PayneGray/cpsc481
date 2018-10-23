board = [["0","*","*","*","*","*","*"],
		["*","*","*","*","*","*","*"],
		["*","*","*","*","*","*","*"],
		["*","*","*","*","*","*","*"],
		["*","*","*","*","*","*","*"],
		["*","*","*","*","*","*","*"],
		["*","*","*","*","*","*","*"]]

current = [0,0]
steps = []
def pos_move(row,col):
	move = [[0,-1],[0,1],[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1],[1,0],[-1,0]]
	moves = []
	for i in move:
		if (row+i[0])>=0 and (row+i[0])<=6 and (col+i[1])>=0 and (col+i[1])<=6:
			if board[row+i[0]][col+i[1]]=="*":# or board[row+i[0]][col+i[1]]=="0" :
				moves.append([row+i[0],col+i[1]])
	print row,col
	print moves
	return moves
count = 0
while len(pos_move(current[0],current[1]))>0:

	for i in pos_move(current[0],current[1]):
		current = [pos_move(current[0],current[1])[0][0],pos_move(current[0],current[1])[0][1]]
		steps.append(current)
		if board[current[0]][current[1]]=="*":
			board[current[0]][current[1]]="0"
		# elif board[current[0]][current[1]]=="0":
		# 	board[current[0]][current[1]]="1"
		break

for i in board:
	print i
print steps