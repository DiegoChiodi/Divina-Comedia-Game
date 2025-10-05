extends Node2D

var camera : Camera = Camera.new()
var player : Player = preload("res://Scene/player.tscn").instantiate()
@onready var shadow : ShadowEnemy = $Shadow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	DisplayServer.window_set_size(DisplayServer.screen_get_size())
	center_window(DisplayServer.screen_get_size())
	add_child(player)
	self.camera.setup(player, null)
	add_child(self.camera) #PROVISÓRIO
	for i in range(32):
		var square : ColorRect = ColorRect.new()
		square.size = Vector2(16,16)
		square.position = Vector2(i * 128, 0)
		add_child(square)
		for j in range(32):
			var square2 : ColorRect = ColorRect.new()
			square2.size = Vector2(16,16)
			square2.position = Vector2(i * 128, j * 128)
			add_child(square2)
	
	shadow.setup(player)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func center_window(new_size: Vector2i):
	# define o tamanho da janela
	DisplayServer.window_set_size(new_size)
	# pega o tamanho da tela
	var screen_size = DisplayServer.screen_get_size()
	# calcula posição para centralizar
	var pos = (screen_size - new_size) / 2
	# move a janela
	DisplayServer.window_set_position(pos)
