extends Enemy
class_name ConfuseEnemy

var perseguition : float = 0.02

func _ready() -> void:
	super._ready()
	speedFix = randi_range(500,800)
	life = 50
	
func directionTarget() -> void:
	if player != null:
		self.direction = lerp(self.direction, (self.player.position - self.position).normalized(), perseguition)
