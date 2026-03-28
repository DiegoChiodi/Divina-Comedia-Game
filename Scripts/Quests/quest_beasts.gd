extends Quest
class_name QuestBeasts

const BOSS_LOSE_MAX : int = 3
var boss_lose : int = 0

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Top_Mountain_00:
		_level.init_quest_beasts()

func on_enemy_destroyed (_enemy) -> void:
	self.boss_lose += 1
	if self.boss_lose == self.BOSS_LOSE_MAX:
		on_quest_finish()

func on_quest_finish() -> void:
	super.on_quest_finish()
	game_manager.change_room(GameManager.LevelID.MOUNTAIN_00)
	game_manager.player.life = game_manager.player.lifeMax
