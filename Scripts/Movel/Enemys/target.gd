extends Enemy
class_name Target

func _ready() -> void:
	super._ready()
	self.iniScale = Vector2.ZERO
	
func speedTarget() -> float:
	return 0.0

func directionTarget(_delta) -> void:
	self.direction = Vector2.ZERO

func takeAttack(_impulseDir : Vector2, _damage : float = 0.0, _impulseSpeed : float = 2000):
	self.takeDamage(0.0)
	self.takeImpulseDir(_impulseDir)
