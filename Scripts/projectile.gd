extends CharacterBody2D
class_name Projectile

var dir : Vector2 = Vector2.RIGHT
var speed : float = 250
var damage : float = 10
var decreaseScale : float = 1.0

func _process(_delta: float) -> void:
	self.position += self.dir * self.speed * _delta
	self.scale = self.scale.lerp(Vector2.ZERO, 0.2 * _delta * self.decreaseScale)
	
	if self.scale.length() < 0.1:
		self.self_destruction()
	
func self_destruction() -> void:
	self.queue_free()
