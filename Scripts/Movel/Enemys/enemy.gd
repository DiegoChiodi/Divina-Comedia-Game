extends Entity
class_name Enemy

var colPlayer : bool = false
var colDetectPlayer : Area2D 
var seeingPlayer : bool = false

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func checkCollidingRival(body) -> bool:
	if (body == game_manager.player):
		return true
	return false

func directionTarget(_delta) -> void:
	if game_manager.player != null and self.seeingPlayer:
		self.direction = (game_manager.player.position - self.position).normalized()

func groupsAdd() -> void:
	add_to_group("Enemy")
	groupRival = "Player"

func _on_are_check_player_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		self.seeingPlayer = true
