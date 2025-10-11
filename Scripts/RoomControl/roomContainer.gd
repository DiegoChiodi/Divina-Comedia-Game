extends Node2D
class_name RoomContainer

var player: Player
var camera: Camera

var currentRoom : BaseScene
var currentRoomPath : String

func setup(_player: Player, _camera: Camera) -> void:
	player = _player
	camera = _camera

func destroy_room() -> void:
	self.currentRoom.call_deferred("queue_free")

func load_room(path : String) -> void:
	self.currentRoomPath = path
	self.currentRoom = load(currentRoomPath).instantiate()
	if self.currentRoom is BaseScene:
		self.currentRoom.setup(self.player, self.camera)
	self.currentRoom.setPlayerSpawn()
	self.call_deferred('add_child', self.currentRoom)
	game_manager.tileTemp(self.currentRoom)

func change_room(path : String) -> void:
	destroy_room()
	load_room(path)

func restart_room() -> void:
	change_room(currentRoomPath)
	
