extends Map
class_name Map_Circle

func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.VESTIBULE_ENTER

func _on_enter_vestibule_enter_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !self.locked_map:
		game_manager.change_room(GameManager.LevelID.VESTIBULE_ENTER_00)
