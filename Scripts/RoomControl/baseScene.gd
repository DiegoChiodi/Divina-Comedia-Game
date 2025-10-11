extends Node2D
class_name BaseScene

var player: Player
var camera: Camera
var roomSize : Marker2D
var playerSpawn : Marker2D

func setup(_player: Player, _camera: Camera) -> void:
	player = _player
	camera = _camera

func _ready() -> void:
	setPlayerSpawn()
	setRoomSize()
	
func setPlayerSpawn() -> void:
	if has_node('playerSpawn'):
		playerSpawn = $playerSpawn
		player.global_position = playerSpawn.global_position
		
func setRoomSize() -> void:
	if has_node('roomSize'):
		roomSize = $roomSize
		camera.setLimit(roomSize.global_position)
