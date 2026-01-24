extends Level
class_name Level_Moutain_00

const shadow_path : String = "res://Scene/Enemys/shadow_enemy.tscn"
const shield_path : String = "res://Scene/Enemys/shieldEnemy.tscn"
const ranged_path : String = "res://Scene/Enemys/rangeEnemy.tscn"
const confused_path : String = "res://Scene/Enemys/confuseEnemy.tscn"

func _process(delta: float) -> void:
	if game_manager.player != null:
		game_manager.ui.clr_shadow.color.a = game_manager.player.position.y / self.map.roomSize.y - 100.0 / 255.0

func load_pt(pt : int) -> void:
	var pt_node = get_node('pt_' + str(pt)) 
	unload(pt)

func unload(pt : int) -> void:
	var pt_node = get_node('pt_' + str(pt)) 
	
	'for children in childrens:
		if children is Enemy:
			children.queue_free()'
