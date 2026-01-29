extends Quest
class_name QuestMountain

const ENEMYSMAX_PTS : Array[int] = [7, 9, 18, 11, 16]
var enemys_dead : int = 0

var actual_pt : int = 0

func on_level_loaded (_level: Level) -> void:
	if _level is Level_Moutain_00:
		self.enemys_dead = 0
		_level.load_pt(actual_pt)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("b"):
		var actual_level := game_manager.roomContainer.currentRoom 
		self.enemys_dead = 0
		if self.actual_pt > self.ENEMYSMAX_PTS.size():
			quest_manager.questFinish()
			return
		actual_level.load_pt(actual_pt)
		

func on_enemy_destroyed (_enemy: Enemy) -> void:
	var actual_level := game_manager.roomContainer.currentRoom 
	if actual_level is Level_Moutain_00:
		self.enemys_dead += 1
		if self.enemys_dead >= self.ENEMYSMAX_PTS[self.actual_pt]:
			self.actual_pt += 1
			self.enemys_dead = 0
			if self.actual_pt == self.ENEMYSMAX_PTS.size():
				quest_manager.questFinish()
				return
			
			actual_level.load_pt(actual_pt)
