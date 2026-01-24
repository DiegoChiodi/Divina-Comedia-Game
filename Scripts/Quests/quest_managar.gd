extends Node
class_name QuestManager

enum QuestID {
	INITIAL,
	BOSS,
	MOUNTAIN,
	RUN
}

var quest_types = {
	QuestID.INITIAL : QuestInitial,
	QuestID.BOSS : QuestBoss,
	QuestID.MOUNTAIN: QuestMountain,
	QuestID.RUN : QuestRun
}


var current_quest : Quest
var quests : Array[Quest] = [QuestInitial.new(), QuestBoss.new(), QuestMountain.new()]

func _init () -> void:
	self.current_quest = self.quests[0]
	
func questFinish() -> void:
	self.quests.remove_at(0)
	if self.quests.is_empty():
		return
	self.current_quest = self.quests[0]
	"
	var next_quest_id : QuestID = self.current_quest.id + 1
	print(next_quest_id)
	self.current_quest = self.quest_types[next_quest_id].new()
	"
