extends BeastBase
class_name LionMain

var lions : Array[Lion]
var lion_scene := preload("res://Scene/Enemys/Beasts/lion.tscn")
var speed_dash = 700.0

var started_attack : bool = true

var return_pos_delay : float = 1.5
var return_pos_wait : float = 0.0

var dash_duration_delay : float = 2.5
var dash_duration_wait : float = 0.0

func _ready() -> void:
	super._ready()
	var lion : Lion = self.lion_scene.instantiate()
	self.add_child(lion)
	self.lions.append(lion)
	self.attack_delay_1 = 1000.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func in_attack_1 (_delta : float) -> void:
	if self.started_attack:
		var lion_new_1 : Lion = self.lion_scene.instantiate()
		var lion_new_2 : Lion = self.lion_scene.instantiate()
		self.add_child(lion_new_1)
		self.add_child(lion_new_2)
		self.lions.append(lion_new_1)
		self.lions.append(lion_new_2)
		
		var random_angle : int = randi() % 360
		for i in range(3):
			if game_manager.player != null:
				var random_dir = Vector2.ONE.rotated(deg_to_rad(120 * i + random_angle)) * 800
				var pos_target = game_manager.player.global_position + random_dir
				self.lions[i].set_pos(pos_target)
				self.lions[i].dir_dash = self.lions[i].global_position.direction_to(game_manager.player.global_position)
		
		self.started_attack = false
	

	if self.dash_duration_wait < self.dash_duration_delay:
		self.dash_duration_wait += _delta
		for i in range(3):
			if game_manager.player != null:
				self.lions[i].set_pos(self.lions[i].global_position + self.lions[i].dir_dash * self.speed_dash * _delta)
	
	else:
		if self.return_pos_wait < self.return_pos_delay:
			self.return_pos_wait += _delta
			if self.lions.size() > 1:
				self.lions[1].queue_free()
				self.lions[2].queue_free()
				self.lions.pop_back()
				self.lions.pop_back()
			
			self.lions[0].set_pos(lerp(self.lions[0].global_position, self.global_position, 0.03))
			self.lions[0].dir_dash = Vector2.ZERO
			self.lions[0].rotation = lerp_angle(self.lions[0].rotation, 0.0, deg_to_rad(100) * _delta)
		else:
			self.attack_wait_1 = 1000.0
			self.started_attack = true
			self.dash_duration_wait = 0.0
			self.return_pos_wait = 0.0
