extends Quest
class_name QuestInitial

const ENEMYSMAX : int = 3
var enemys_dead : int = 0
func _ready() -> void:
	self.id = QuestManager.QuestID.INITIAL

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Florest_00:
		_level.quest_initial()

func on_enemy_destroyed (_enemy: Enemy) -> void:
	if _enemy is ShadowEnemy:
		self.enemys_dead += 1
		if self.enemys_dead == self.ENEMYSMAX:
			quest_manager.questFinish()
