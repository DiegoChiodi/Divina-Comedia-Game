extends Entity
class_name Enemy

var colPlayer : bool = false

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func checkCollidingRival(body) -> bool:
	if (body == game_manager.player and game_manager.player.inDash):
		return true
	return false

func directionTarget(_delta) -> void:
	if game_manager.player != null:
		self.direction = (game_manager.player.position - self.position).normalized()

func groupsAdd() -> void:
	add_to_group("Enemy")
	groupRival = "Player"
