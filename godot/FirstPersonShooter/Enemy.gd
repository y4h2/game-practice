extends KinematicBody
# stats
var health : int = 5
var moveSpeed : float = 2.0


# attacking
var damage : int = 1
var attackRate : float = 1.0
var attackDist : float = 2.0
var scoreToGive : int = 10


# components
onready var player : Node = get_node("/root/MainScene/Player")
onready var timer : Node = get_node("Timer")


func _ready():

	# setup the timer
	timer.set_wait_time(attackRate)
	timer.start()

func _physics_process(delta):
	# calculate the direction to the player
	var dir = (player.translation - translation).normalized()
	dir.y = 0
	
	# move the enemy towards the player
	move_and_slide(dir * moveSpeed, Vector3.UP)

	# move the enemy towards the player
	if translation.distance_to(player.translation) > attackDist:
		move_and_slide(dir * moveSpeed, Vector3.UP)

func take_damage (damage):
	health -= damage
  
	if health <= 0:
		die()

func die ():
	player.add_score(scoreToGive)
	queue_free()

func attack():
	player.take_damage(damage)  

func _on_Timer_timeout():
	if translation.distance_to(player.translation) <= attackDist:
		attack()
