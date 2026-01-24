extends Level
class_name Level_Florest_00

var shadow := preload("res://Scene/Enemys/shadow_enemy.tscn").instantiate()
var shadow2 := preload("res://Scene/Enemys/shadow_enemy.tscn").instantiate()
var shadow3 := preload("res://Scene/Enemys/shadow_enemy.tscn").instantiate()

func _process(_delta: float) -> void:
	if shadow == null:
		global.shadowLive = false

func init_quest_initial() -> void:
	var clr_shadow = game_manager.ui.clr_shadow
	clr_shadow.color.a = 100.0 / 255.0
	
	shadow.position = $shadow_pos.position
	shadow2.position = $shadow_pos2.position
	shadow3.position = $shadow_pos3.position
	add_child(shadow)
	add_child(shadow2)
	add_child(shadow3)
