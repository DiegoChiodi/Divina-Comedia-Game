extends BeastBase
class_name Wolf

const RADIOUS_MAX: float = 1000
var radious : float = self.RADIOUS_MAX
var radious_speed : float = 50.0
var angle : float = 0.0
var angle_speed : float = 360.0
var center : Vector2

var normal_position : Vector2 = Vector2(703, 128)

var difficult = 0.5
var mult_difficult = 1.0

func attack_process(_delta : float) -> void:
	if self.attack_wait > self.attack_delay - 1.5:
		self.return_normal(_delta)
	else:
		var dir : Vector2 = Vector2(cos(deg_to_rad(self.angle)), sin(deg_to_rad(self.angle))).normalized()
		self.radious = lerp(self.radious, 0.0, 0.98 * _delta / 4 * self.difficult)
		self.angle += self.angle_speed * _delta * max(self.radious / self.RADIOUS_MAX, 0.2) * self.difficult
		self.position = self.radious * dir - self.center
		self.rotation_personality = self.angle + 90

func start_attack () -> void:
	super.start_attack()
	self.center = global.roomLimit / 2 + Vector2(0, -200.0) 
	self.attack_delay = max(9.0 - self.difficult * 2, 4.0)
	self.difficult += self.mult_difficult
	self.radious = self.RADIOUS_MAX
	self.angle = 0.0

func return_normal(_delta : float) -> void:
	self.global_position = lerp(self.global_position, self.normal_position, 2.5 * _delta)
	self.rotation_personality = 0.0
