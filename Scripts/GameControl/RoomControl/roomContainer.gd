extends Node2D
class_name RoomContainer

var currentRoom : Level
var previousMapId

var inInit : bool = true
func destroy_room() -> void:
	self.currentRoom.call_deferred("queue_free")

func load_room(path : String) -> void:
	if !inInit:
		self.previousMapId = self.currentRoom.map.id
	self.currentRoom = load(path).instantiate()
	self.currentRoom.setup()
	self.add_child(self.currentRoom)
	
	if !inInit:
		var marker_name = game_manager.marker_names[previousMapId]
		var marker : Marker2D = currentRoom.map.get_node(marker_name)
		var position = marker.position
		game_manager.player.set_deferred("position", position)
		game_manager.camera.setPosition(position)
	else:
		var position = self.currentRoom.map.get_node("player_spawn").position
		game_manager.player.set_deferred("position", position)
		game_manager.camera.setPosition(position)
	inInit = false

func change_room(path : String) -> void:
	destroy_room()
	load_room(path)

func restart_room() -> void:
	change_room(currentRoom.get_path())
