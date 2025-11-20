extends Node2D
class_name GameManager

enum MapID {
	FOREST,
	VESTIBULE,
	TUTORIAL
}

enum LevelID {
	FOREST_00,
	VESTIBULE_00
}

var level_paths : Dictionary = {
	LevelID.FOREST_00 : 'res://Scene/level_forest_00.tscn',
	LevelID.VESTIBULE_00 : 'res://Scene/level_vestibule_00.tscn'
}

var marker_names : Dictionary = {
	MapID.FOREST : 'marker_from_forest',
	MapID.VESTIBULE:  'marker_from_vestibule'
}

var camera : Camera = Camera.new()
var player : Player = preload("res://Scene/player.tscn").instantiate()
var roomContainer : RoomContainer = RoomContainer.new()

#Scenes
var debugScene : String = "res://Scene/debugMap.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	windowsConf()

func _process(_delta: float) -> void:
	if Input.is_action_just_released("restart"):
		restartRoom()

func init(main : Node2D):
	self.camera.setup(player, null)
	camera.limit_left = 0
	camera.limit_top = 0
	main.add_child(camera)
	main.add_child(player)
	roomContainer.load_room(level_paths[LevelID.FOREST_00])
	main.add_child(roomContainer)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	DisplayServer.window_set_size(DisplayServer.screen_get_size())
	center_window(DisplayServer.screen_get_size())

func center_window(new_size: Vector2i):
	# define o tamanho da janela
	DisplayServer.window_set_size(new_size)
	# pega o tamanho da tela
	var screen_size = DisplayServer.screen_get_size()
	# calcula posição para centralizar
	var pos = (screen_size - new_size) / 2
	# move a janela
	DisplayServer.window_set_position(pos)

func windowsConf() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	DisplayServer.window_set_size(DisplayServer.screen_get_size())
	center_window(DisplayServer.screen_get_size())

func start_shake(intensity: float, decay: float = 1.0) -> void:
	camera.start_shake(intensity,decay)

func restartRoom():
	var actualMapId = roomContainer.currentRoom.map.id
	self.player.queue_free()
	
	var newPlayer : Player = preload("res://Scene/player.tscn").instantiate()
	self.player = newPlayer
	self.add_child(self.player)
	self.camera.setup(player, null)
	roomContainer.restartRoom(level_paths[actualMapId])
	 

func change_room(_map_id) -> void:
	roomContainer.call_deferred("change_room", level_paths[_map_id])
