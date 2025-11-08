extends Enemy
class_name Target

func _ready() -> void:
	iniScale = Vector2.ZERO
	
func speedTarget() -> float:
	return 0.0

func directionTarget(_delta) -> void:
	direction = Vector2.ZERO

func takeAttack(_impulseDir : Vector2, _damage : float = 0.0, _impulseSpeed : float = 2000):
	takeDamage(0.0)
	takeImpulseDir(_impulseDir)
