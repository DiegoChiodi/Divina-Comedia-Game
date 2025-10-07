extends Entity
class_name Enemy

var player : Player
var colPlayer : bool = false
func _ready() -> void:
	super._ready()
	speed = 100
	
func _physics_process(delta: float) -> void:
	move_directionTarget()
	super._physics_process(delta)


func setup(_player : Player) -> void:
	player = _player

func directionTarget() -> void:
	if player != null:
		self.direction = (self.player.position - self.position).normalized()

func _on_col_hb_attack_area_entered(area: Area2D) -> void:
	if area.get_parent() == player:
		colPlayer = true

func _on_col_hb_attack_area_exited(area: Area2D) -> void:
	if area.get_parent() == player:
		colPlayer = false

func groupsAdd() -> void:
	add_to_group("Enemy")
	groupRival = "Player"
