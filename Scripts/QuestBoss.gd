extends Quest
class_name QuestBoss

func _ready() -> void:
	self.id = QuestManager.QuestID.BOSS

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Vestibule_00:
		_level.init_quest_boss()

func on_enemy_destroyed (_enemy: Enemy) -> void:
	if _enemy is ShadowBoss:
		quest_manager.questFinish()
		print('gg')
