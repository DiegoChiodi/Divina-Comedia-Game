extends Enemy
class_name ConfuseEnemy

var perseguition : float = 0.02

func _ready() -> void:
	super._ready()
	speedFix = randi_range(300,600)
	life = 50
	
func setDirection() -> Vector2:
	return lerp(self.direction, (game_manager.player.position - self.position).normalized(), perseguition)


func takeImpulseDir(_impulseDir : Vector2, _impulseSpeed : float = 500) -> void:
	super.takeImpulseDir(_impulseDir,_impulseSpeed)
