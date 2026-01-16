extends Map
class_name MapVestibule

func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.VESTIBULE

func _process(delta: float) -> void:
	self.locked_map = quest_manager.current_quest is QuestBoss

func _on_enter_forest_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !self.locked_map:
		game_manager.change_room(GameManager.LevelID.FOREST_00)

func _on_enter_mountain_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !self.locked_map:
		game_manager.change_room(GameManager.LevelID.MOUNTAIN_00)
