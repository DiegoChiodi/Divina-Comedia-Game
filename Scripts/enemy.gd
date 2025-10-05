extends Entity
class_name Enemy

var player : Player

func _ready() -> void:
	super._ready()
	speed = 100
	
func _physics_process(delta: float) -> void:
	move_directionTarget()
	super._physics_process(delta)

func setup(_player : Player) -> void:
	player = _player

func directionTarget() -> void:
	self.direction = (self.player.position - self.position).normalized()

func groupsAdd() -> void:
	add_to_group("Enemy")
	groupRival = "Player"
