extends Enemy
class_name ShadowEnemy

func _ready() -> void:
	super._ready()
	speedFix = randi_range(120,180)
	life = 80
