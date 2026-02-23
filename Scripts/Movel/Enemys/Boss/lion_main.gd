extends BeastBase
class_name LionMain

var lions : Array[Lion]
var lion_scene := preload("res://Scene/Enemys/Beasts/lion.tscn")
func _ready() -> void:
	super._ready()
	var lion : Lion = self.lion_scene.instantiate()
	self.add_child(lion)
	self.lions.append(lion)
	print('a')
	print(lion)
