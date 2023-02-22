extends Camera2D

onready var player = get_node("/root/MainScene/Player")
#This function gets called every frame
func _process (delta):
	position.x = player.position.x
