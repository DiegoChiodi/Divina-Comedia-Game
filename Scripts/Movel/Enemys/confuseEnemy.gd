extends Enemy
class_name ConfuseEnemy

var perseguition : float = 0.02

func _ready() -> void:
	super._ready()
	self.speedFix = randi_range(300,600)
	self.life = 50
	
func setDirection() -> Vector2:
	return lerp(self.direction, (game_manager.player.position - self.position).normalized(), perseguition)
