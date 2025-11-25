extends Enemy
class_name ConfuseEnemy

var perseguition : float = 0.02

func _ready() -> void:
	super._ready()
	speedFix = randi_range(300,600)
	life = 50
	
func directionTarget(_delta : float) -> void:
	if game_manager.player != null and self.seeingPlayer:
		self.direction = lerp(self.direction, (game_manager.player.position - self.position).normalized(), perseguition)
	else:
		if self.inLengthen:
			return
		self.direction = self.direction.lerp(Vector2.ZERO,0.1)
