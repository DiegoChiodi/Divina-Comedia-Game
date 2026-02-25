extends BeastBase
class_name LionMain

var lions : Array[Lion]
var lion_scene := preload("res://Scene/Enemys/Beasts/lion.tscn")

var started_attack : bool = true
var random_dir : Vector2

func _ready() -> void:
	super._ready()
	var lion : Lion = self.lion_scene.instantiate()
	self.add_child(lion)
	self.lions.append(lion)
	self.attack_delay_1 = 10.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func in_attack_1 (_delta : float) -> void:
	if self.started_attack:
		self.random_dir = Vector2((randi() % 100), (randi() % 100)).normalized()
		
		for i in range(2):
			var lion : Lion = self.lion_scene.instantiate()
			if game_manager.player != null:
				lion.global_position = game_manager.player.global_position + random_dir.rotated(deg_to_rad(120 * i)) * 10
				self.add_child(lion)
				self.lions.append(lion)
			print('instantied')
		
		self.started_attack = false
