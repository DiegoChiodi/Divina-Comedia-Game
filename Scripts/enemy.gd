extends Movel
class_name Enemy

var player : CharacterBody2D

func _ready() -> void:
	super._ready()
	speed = 100
	
func setup(_player : Player) -> void:
	player = _player

func directionTarget() -> void:
	self.direction = (self.player.position - self.position).normalized()

func _physics_process(delta: float) -> void:
	move_directionTarget()
	super._physics_process(delta)
	
