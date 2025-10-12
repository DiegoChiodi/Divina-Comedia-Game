extends ConfuseEnemy
class_name ShieldEnemy

@onready var shield : Node2D = $shield

func _ready() -> void:
	super._ready()
	speedFix = 200
	perseguition = 0.01
	life = 40


func checkCollidingRival(body) -> bool:
	if (super.checkCollidingRival(body) 
	and (are_directions_similar(self.direction, (self.position - body.position).normalized(), 90)
	or body.direction.length() > 0.05)):
		return true
	return false
	invencibilityActivate()

func are_directions_similar(a: Vector2, b: Vector2, tolerance_degrees: float = 30.0) -> bool:
	if a == Vector2.ZERO or b == Vector2.ZERO:
		return false

	var cos_tolerance = cos(deg_to_rad(tolerance_degrees))
	var dot_value = a.normalized().dot(b.normalized())

	return dot_value >= cos_tolerance

func _process(delta: float) -> void:
	super._process(delta)
	self.rotation = lerp_angle(self.rotation, (self.direction).angle(), acceleration) 
