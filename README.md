===== PSEUDOCODE =====

ants = []
num-ants-found-goal = 0					# Number of ants that found the goal
shortest-path = [] 						# The shortest closed list of any ant

while (num-ants-found-goal < 30):
	if ant.mode = 1:					# Drop scent if we found food
		drop-scent

	foreach ant in ants:
		move-ant(ant)
		if at-goal(ant):
			ant.mode = 1
			num-ants-found-goal ++		# Compare the path this ant found to the
			update shortest-path		# current shortest path & update shortest
		if at-start(ant): 				
			ants.remove(ant)

	evaporate-scent()
	if sizeof ants < 50:				# No more than 50 ants on the grid at once
		spawn-ant()

return shortest-path					# We need to be able to print this out!

