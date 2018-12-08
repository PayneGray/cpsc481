===== PSEUDOCODE =====

ants = []
num-ants-found-goal = 0
shortest-path = []

while (num-ants-found-goal < 30):
	foreach ant in ants:
		move-ant(ant)
		if at-goal(ant):
			ant.mode = 1
			num-ants-found-goal ++
			update shortest-path
		if at-start(ant): 
			ants.remove(ant)

	migrate-scent()
	evaporate-scent()
	if sizeof ants < 50:
		spawn-ant()

return shortest-path

