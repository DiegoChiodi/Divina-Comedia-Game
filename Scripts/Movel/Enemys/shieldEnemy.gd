extends ConfuseEnemy
class_name ShieldEnemy

@onready var shield : Node2D = $shield

func _ready() -> void:
	super._ready()
	self.speedFix = 200
	self.perseguition = 0.01
	self.life = 100

func are_directions_similar(a: Vector2, b: Vector2, tolerance_degrees: float = 120.0) -> bool:
	if a == Vector2.ZERO or b == Vector2.ZERO:
		return false

	var cos_tolerance = cos(deg_to_rad(tolerance_degrees))
	var dot_value = a.normalized().dot(b.normalized())

	return dot_value >= cos_tolerance

func _process(delta: float) -> void:
	super._process(delta)

func collidingRival(_body : Player) -> void:
	var player_dir : Vector2 = self.position.direction_to(_body.position)
	if are_directions_similar(player_dir, Vector2.RIGHT.rotated(self.rotation)):
		self.takeImpulse((self.position - _body.position).normalized(), _body.speed)
		_body.takeImpulse((_body.position - self.position).normalized(), 300)
		return
	super.collidingRival(_body)

func rotationSet(delta) -> void:
	if self.seeingPlayer:
		self.rotation = lerp_angle(self.rotation, (game_manager.player.position - self.position).angle(), delta * 1)

func setDirection() -> Vector2:
	return lerp(self.direction, (game_manager.player.position - self.position).normalized(), perseguition)
