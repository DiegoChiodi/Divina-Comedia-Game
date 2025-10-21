extends Node2D
class_name RoomContainer

var currentRoom : Level
var currentRoomPath : String

func destroy_room() -> void:
	self.currentRoom.call_deferred("queue_free")

func load_room(path : String) -> void:
	self.currentRoomPath = path
	self.currentRoom = load(currentRoomPath).instantiate()
	self.call_deferred('add_child', self.currentRoom)
	tileTemp(self.currentRoom)

func tileTemp(room : Level) -> void:
	for i in 32:
		var square : ColorRect = ColorRect.new()
		square.size = Vector2(16,16)
		square.position = Vector2(i * 128, 0)
		room.add_child(square)
		for j in 32:
			var square2 : ColorRect = ColorRect.new()
			square2.size = Vector2(16,16)
			square2.position = Vector2(i * 128, j * 128)
			room.add_child(square2)

func change_room(path : String) -> void:
	destroy_room()
	load_room(path)

func restart_room() -> void:
	change_room(currentRoomPath)
	
