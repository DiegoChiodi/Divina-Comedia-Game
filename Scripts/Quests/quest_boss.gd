extends Quest
class_name QuestBoss

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Vestibule_00:
		_level.init_quest_boss()

func on_enemy_destroyed (_enemy) -> void:
	if _enemy is ShadowBoss:
		self.on_quest_finish()
