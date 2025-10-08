extends Enemy
class_name ConfuseEnemy

func _ready() -> void:
	super._ready()
	speedFix = randi_range(500,800)
	
func directionTarget() -> void:
	if player != null:
		self.direction = lerp(self.direction, (self.player.position - self.position).normalized(), 0.02)
