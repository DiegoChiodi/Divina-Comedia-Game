extends Level
class_name Level_Top_Mountain_00

const beasts : String = "res://Scene/Enemys/Beasts/beasts.tscn"

@onready var mar_beasts_spawn : Marker2D = $mar_beasts_spawn

func init_quest_beasts () -> void:
	var beasts_ins : BeastsManager = load(self.beasts).instantiate()
	beasts_ins.position = self.mar_beasts_spawn.position
	self.add_child(beasts_ins)
