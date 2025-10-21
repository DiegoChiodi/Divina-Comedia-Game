extends Node
class_name Map

var id : int

var roomSize : Marker2D
var playerSpawn : Marker2D

func _ready() -> void:
	setRoomSize()

func setRoomSize() -> void:
	if has_node('roomSize'):
		roomSize = $roomSize
		game_manager.camera.setLimit(roomSize.global_position)
