extends Node
class_name Map

var id : int

var roomSize : Vector2
var playerSpawn : Marker2D
var locked_map : bool = false

func _ready() -> void:
	setRoomSize()

func setRoomSize() -> void:
	if has_node('roomSize'):
		self.roomSize = $roomSize.global_position
		game_manager.camera.setLimit(self.roomSize)
		global.roomLimit = self.roomSize

func out_bounds(body : Entity) -> void:
	body.position = body.position.clamp(Vector2.ZERO, global.roomLimit)
