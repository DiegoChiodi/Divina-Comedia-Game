extends Level
class_name Level_Moutain_00

func setup() -> void:
	self.map = get_node('map')

func _process(delta: float) -> void:
	game_manager.ui.clr_shadow.color.a = game_manager.player.position.y / self.map.roomSize.y - 100.0 / 255.0
