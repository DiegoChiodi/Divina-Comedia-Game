extends Enemy
class_name ConfuseEnemy

var perseguition : float = 0.02

func _ready() -> void:
	super._ready()
	speedFix = randi_range(500,800)
	life = 50
	
func directionTarget(delta : float) -> void:
	if game_manager.player != null:
		self.direction = lerp(self.direction, (game_manager.player.position - self.position).normalized(), perseguition)
