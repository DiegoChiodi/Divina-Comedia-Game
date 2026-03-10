extends BeastBase
class_name Wolf

var radious : float = 500 #<_------------
var radious_speed : float = 50.0
var angle : float = 0.0
var angle_speed : float = 5.0
var center : Vector2
func in_attack_1 (_delta : float) -> void:
	var dir : Vector2 = Vector2(cos(self.angle), sin(self.angle)).normalized()
	self.radious = lerp(self.radious, 0.0, 0.98 * _delta / 2)
	self.angle += angle_speed * _delta
	self.position = self.radious * dir - self.center
	print(self.position)
	print(str(game_manager.player.position) + "Player")

func start_attack () -> void:
	super.start_attack()
	self.center = global.roomLimit / 2
	self.attack_delay_1 = 10.0
