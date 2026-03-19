extends Quest
class_name QuestDescend

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Moutain_00:
		_level.init_quest_descend()
