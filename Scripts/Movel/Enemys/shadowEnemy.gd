extends Enemy
class_name ShadowEnemy

func _ready() -> void:
	super._ready()
	self.speedFix = randi_range(120,180)
	self.life = 80
