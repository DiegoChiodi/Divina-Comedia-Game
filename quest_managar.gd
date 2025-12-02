extends Node
class_name QuestManager

enum QuestID {
	INITIAL,
	TEST
}

var current_quest : Quest

var quest_types = {
	QuestID.INITIAL : QuestInitial
}

func _init () -> void:
	self.current_quest = self.quest_types[self.QuestID.INITIAL].new()

func questFinish() -> void:
	var next_quest_id : QuestID = self.current_quest.id + 1
	self.current_quest = self.quest_types[next_quest_id].new()
