extends BeastBase
class_name Wolf

const RADIOUS_MAX: float = 1000
var radious : float = self.RADIOUS_MAX
var radious_speed : float = 50.0
var angle : float = 0.0
var angle_speed : float = 360.0
var center : Vector2

var difficult = 0.5
var mult_difficult = 1.0
func in_attack_1 (_delta : float) -> void:
	var dir : Vector2 = Vector2(cos(deg_to_rad(self.angle)), sin(deg_to_rad(self.angle))).normalized()
	self.radious = lerp(self.radious, 0.0, 0.98 * _delta / 4 * self.difficult)
	self.angle += angle_speed * _delta * max(self.radious / self.RADIOUS_MAX, 0.2) * self.difficult
	self.position = self.radious * dir - self.center

func start_attack () -> void:
	super.start_attack()
	self.center = global.roomLimit / 2 + Vector2(0, -200.0) 
	self.attack_delay_1 = max(8.0 - self.difficult * 2, 4.0)
	self.difficult += self.mult_difficult
	self.radious = self.RADIOUS_MAX
	self.angle = 0.0
