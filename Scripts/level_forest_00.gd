extends Level
class_name Level_Florest_00

func _ready () -> void:
	self.map = $map

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		game_manager.change_room(GameManager.LevelID.VESTIBULE_00)
