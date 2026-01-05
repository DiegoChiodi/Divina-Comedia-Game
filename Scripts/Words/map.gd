extends Node
class_name Map

var id : int

var roomSize : Vector2
var playerSpawn : Marker2D
func _ready() -> void:
	setRoomSize()

func setRoomSize() -> void:
	if has_node('roomSize'):
		roomSize = $roomSize.global_position
		game_manager.camera.setLimit(roomSize)
		global.roomLimit = roomSize
