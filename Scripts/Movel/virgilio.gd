extends AnimationEntity
class_name Virgilio

var trail_points : int = 0

func _ready() -> void:
	super._ready()

func _process(_delta : float) -> void:
	super._process(_delta)
	self.direction = Vector2(-0.6, 0.2)
