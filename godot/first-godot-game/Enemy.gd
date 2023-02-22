extends Area2D

export var speed : int = 100
export var moveDist : int = 100

onready var startX : int = position.x
onready var targetX : int = position.x + moveDist

func _process (delta): 
	#Passing position.x to 'current' / targetX to 'to' / and speed*delta to 'step'.
	position.x = move_to(position.x, targetX, speed * delta)
	#is our position equal to the target?
	if position.x == targetX:
		if targetX == startX:
			targetX = position.x + moveDist
		else:
			targetX = startX


#The function takes in three parameters: current position, destination, and how much it moves in this function call.
func move_to (current, to, step):
	#We will use the new variable to store and modify the current position.
	var new = current

	#If we haven't reached the destination yet
	if new < to:
		#Move positively by step
		new += step
		#If we've gone over the destination
		if new > to:
		  #Cap it out at the destination
		  new = to
	#If we've reached the destination 
	else:
		#Move negatively by step
		new -= step
		#If we've returned to our starting position
		if new < to:
		  #Cap it out at the starting position
		  new = to
	return new


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		body.die()

