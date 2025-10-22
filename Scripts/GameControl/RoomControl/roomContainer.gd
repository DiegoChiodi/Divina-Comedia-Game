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
	self.add_child(self.currentRoom)
	tileTemp(self.currentRoom)
	
	if !inInit:
		var marker_name = game_manager.marker_names[previousMapId]
		var marker : Marker2D = currentRoom.map.get_node(marker_name)
		var position = marker.position
		game_manager.player.set_deferred("position", position)
	inInit = false
func tileTemp(room : Level) -> void:
	var color := Color.WHITE
	
	if room as Level_Florest_00:
		color = Color(1,0.5,0.5)
	else:
		color = Color.GREEN_YELLOW
	
	
	for i in 32:
		for j in 32:
			var square2 : ColorRect = ColorRect.new()
			square2.size = Vector2(16,16)
			square2.position = Vector2(i * 128, j * 128)
			square2.modulate = color
			room.add_child(square2)

func change_room(path : String) -> void:
	destroy_room()
	load_room(path)

func restart_room() -> void:
	change_room(currentRoom.get_path())
	
