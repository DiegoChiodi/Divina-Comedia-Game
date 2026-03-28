extends Quest
class_name QuestDescend

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Moutain_00:
		_level.init_quest_descend()

func on_trade_map(_map_prev : Map, _map_prox : Map) -> void:
	if _map_prox is MapVestibule:
		self.on_quest_finish()
