extends Map
class_name Map_Top_Mountain

func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.TOP_MOUNTAIN
	game_manager.camera.zoomTarget *= 0.8

func _on_enter_top_mountain_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		game_manager.change_room(GameManager.LevelID.MOUNTAIN_00)
