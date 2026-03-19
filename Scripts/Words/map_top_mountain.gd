extends Map
class_name Map_Top_Mountain

func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.TOP_MOUNTAIN
	game_manager.camera.zoomTarget *= 0.8
