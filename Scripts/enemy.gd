extends Entity
class_name Enemy

var player : Player
var colPlayer : bool = false


func _physics_process(delta: float) -> void:
	move_directionTarget()
	super._physics_process(delta)

func checkCollidingRival() -> bool:
	if (rivalId == player and player != null and player.inDash):
		return true
	return false

func setup(_player : Player) -> void:
	player = _player

func directionTarget() -> void:
	if player != null:
		self.direction = (self.player.position - self.position).normalized()

func groupsAdd() -> void:
	add_to_group("Enemy")
	groupRival = "Player"
