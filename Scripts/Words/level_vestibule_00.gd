extends Level
class_name Level_Vestibule_00

var boss : = preload("res://Scene/shadow_boss.tscn").instantiate()
var shadows : Array[CircleDraw] = []
var dialogue := DiaFoundVirgilio.new()
@onready var virg_shadow : Node2D = $virg_shadow
@onready var spawn_virg : Marker2D = $mar_spawn_virg

func _process(_delta: float) -> void:
	shadows_destroy(_delta)

func init_quest_boss() -> void:
	self.boss.position = $mar_boss.position
	add_child(self.boss)
	self.map.locked_map = true
	self.virg_shadow.visible = true

func init_dialogue() -> void:
	game_manager.ui.start_dialogue(self.dialogue)
	self.dialogue.start = true
	global.pause_dialogue = true
	game_manager.player.direction = Vector2.ZERO

func shadows_destroy(_delta : float) -> void:
	for i in range(shadows.size() - 1, -1, -1):
		shadows[i].move(_delta)
		if shadows[i].radious <= 0.75:
			shadows[i].queue_free()
			shadows.remove_at(i)

func start_shadows(_shadows : Array[CircleDraw]) -> void:
	self.shadows = _shadows
