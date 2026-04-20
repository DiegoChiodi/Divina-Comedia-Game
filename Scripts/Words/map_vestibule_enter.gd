extends Map
class_name Map_Vestibule_Enter

func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.VESTIBULE_ENTER

func _on_enter_vestibule_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !self.locked_map:
		game_manager.change_room(GameManager.LevelID.VESTIBULE_00)

func _on_enter_circle_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !self.locked_map:
		game_manager.change_room(GameManager.LevelID.CIRCLE_00)
