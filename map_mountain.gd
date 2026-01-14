extends Map
class_name MapMountain

# Called when the node enters the scene tree for the first time.
func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.MOUNTAIN

func _on_enter_vestibule_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		game_manager.change_room(GameManager.LevelID.VESTIBULE_00)
