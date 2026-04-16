extends Node
class_name QuestManager

var current_quest : Quest
var quests : Array[Quest] = [QuestInitial.new(), QuestFoundVirgilio.new(), QuestBeasts.new(), QuestDescend.new(), QuestBoss.new(), QuestMountain.new()]

func _init () -> void:
	self.current_quest = self.quests[0]
	
func questFinish() -> void:
	self.quests.remove_at(0)
	if self.quests.is_empty():
		return
	self.current_quest = self.quests[0]
