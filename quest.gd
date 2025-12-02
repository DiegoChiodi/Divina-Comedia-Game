extends Node
class_name Quest

var id
var level_of_map = { }
signal quest_finished

func on_level_loaded (level_: Level) -> void:
	pass

func on_level_unloaded (level_: Level) -> void:
	pass

func on_enemy_destroyed (enemy: Enemy) -> void:
	pass
