extends Node
class_name Quest

var id : int
var level_of_map = {}

func on_level_loaded (_level: Level) -> void:
	pass

func on_level_unloaded (_level: Level) -> void:
	pass

func on_enemy_destroyed (_enemy: Enemy) -> void:
	pass

func on_quest_finish() -> void:
	quest_manager.questFinish()

func on_trade_map(_map_prev : Map, _map_prox : Map) -> void:
	pass
