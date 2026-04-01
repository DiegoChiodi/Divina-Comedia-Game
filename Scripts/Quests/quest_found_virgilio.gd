extends Quest
class_name QuestFoundVirgilio

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Vestibule_00:
		_level.init_dialogue()
		
