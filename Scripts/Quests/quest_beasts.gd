extends Quest
class_name QuestBeasts

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Top_Mountain_00:
		game_manager.camera.setZoom(game_manager.camera.zoom * 1.5)
		print('gg')
