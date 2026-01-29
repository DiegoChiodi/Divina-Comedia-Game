extends Map
class_name MapForest

func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.FOREST

func _on_enter_vestibule_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		game_manager.change_room(GameManager.LevelID.VESTIBULE_00)
