extends Node2D
class_name BaseScene

var roomSize : Marker2D
var playerSpawn : Marker2D

func _ready() -> void:
	setPlayerSpawn()
	setRoomSize()
	
func setPlayerSpawn() -> void:
	if has_node('playerSpawn'):
		playerSpawn = $playerSpawn
		game_manager.player.global_position = playerSpawn.global_position
		
func setRoomSize() -> void:
	if has_node('roomSize'):
		roomSize = $roomSize
		game_manager.camera.setLimit(roomSize.global_position)
