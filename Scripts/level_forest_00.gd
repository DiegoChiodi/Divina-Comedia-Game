extends Level
class_name Level_Florest_00

var shadow := preload("res://Scene/Enemys/shadow.tscn").instantiate()

func _ready() -> void:
	if !global.shadowLive:
		shadow.position = $shadow_pos.position
		add_child(shadow)

func _process(_delta: float) -> void:
	if shadow == null:
		global.shadowLive = false

func setup() -> void:
	self.map = get_node('map')
