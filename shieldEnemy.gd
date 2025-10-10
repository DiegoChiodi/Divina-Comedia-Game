extends ConfuseEnemy
class_name ShieldEnemy


func _ready() -> void:
	super._ready()
	speedFix = 200
	perseguition = 0.01
	
func checkCollidingRival() -> bool:
	if (super.checkCollidingRival() and self.rivalId != null
	and (are_directions_similar(self.direction, self.rivalId.direction, 120)
	or self.rivalId.direction.length() > 0.05)):
		return true
	return false

func are_directions_similar(a: Vector2, b: Vector2, tolerance_degrees: float = 30.0) -> bool:
	if a == Vector2.ZERO or b == Vector2.ZERO:
		return false

	var cos_tolerance = cos(deg_to_rad(tolerance_degrees))
	var dot_value = a.normalized().dot(b.normalized())

	return dot_value >= cos_tolerance
