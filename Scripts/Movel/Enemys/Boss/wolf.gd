extends BeastBase
class_name Wolf

var radious : float
var radious_speed : float = 100.0
var center : Vector2
var angle : float = 0.0
var angle_speed : float = 100.0

func in_attack_1 (_delta : float) -> void:
	var dir : Vector2 = Vector2(cos(self.angle), sin(self.angle)).normalized()
	self.radious -= self.radious_speed * _delta
	self.angle += angle_speed * _delta
	self.position = self.center + self.radious * dir

func start_attack () -> void:
	super.start_attack()
	self.center = global.roomLimit / 2
	self.radious = (self.global_position - self.center).length()
	self.attack_delay_1 = 10.0
