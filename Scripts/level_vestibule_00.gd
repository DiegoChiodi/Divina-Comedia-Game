extends Level
class_name Level_Vestibule_00

var boss : = preload("res://Scene/bossShadow.tscn").instantiate()

func setup() -> void:
	self.map = $map

func init_quest_boss() -> void:
	self.boss.position = $mar_boss.position
	add_child(self.boss)
