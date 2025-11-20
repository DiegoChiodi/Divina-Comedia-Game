extends Node2D
class_name RoomContainer

var currentRoom : Level
var previousMapId : int

var inInit : bool = true
var restart : bool = false

func destroy_room() -> void:
	self.currentRoom.call_deferred("queue_free")

func load_room(path) -> void:
	if !self.inInit and !self.restart:
		self.previousMapId = self.currentRoom.map.id
	
	self.currentRoom = load(path).instantiate()
	
	self.currentRoom.setup()
	self.add_child(self.currentRoom)
	
	if !inInit:
		var marker_name = game_manager.marker_names[previousMapId]
		var marker : Marker2D = currentRoom.map.get_node(marker_name)
		if marker != null:
			var mark_position = marker.position
			game_manager.player.set_deferred("position", mark_position)
			game_manager.camera.setPosition(mark_position)
		
		if previousMapId == currentRoom.map.id:
			var mark_position = self.currentRoom.map.get_node("player_spawn").position
			game_manager.player.set_deferred("position", mark_position)
			game_manager.camera.setPosition(mark_position)
	else:
		var mark_position = self.currentRoom.map.get_node("player_spawn").position
		game_manager.player.set_deferred("position", mark_position)
		game_manager.camera.setPosition(mark_position)
	self.inInit = false
	self.restart = false

func change_room(path) -> void:
	destroy_room()
	load_room(path)

func restartRoom(path: String) -> void:
	self.restart = true
	change_room(path)
