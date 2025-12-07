extends Node
class_name Quest

var id
var level_of_map = {}

func on_level_loaded (_level: Level) -> void:
	pass

func on_level_unloaded (_level: Level) -> void:
	pass

func on_enemy_destroyed (_enemy: Enemy) -> void:
	pass
