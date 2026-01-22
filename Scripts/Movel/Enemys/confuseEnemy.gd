extends Enemy
class_name ConfuseEnemy

var perseguition : float = 0.02

func _ready() -> void:
	super._ready()
	self.speedFix = 500.0
	self.life = 50.0
	
func setDirection() -> Vector2:
	return lerp(self.direction, (game_manager.player.position - self.position).normalized(), perseguition)

func takeDamage(_damage : float) -> void:
	self.direction *= 0.3
