extends Map
class_name MapVestibule

func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.VESTIBULE


func _on_enter_forest_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		game_manager.change_room(GameManager.LevelID.FOREST_00)
