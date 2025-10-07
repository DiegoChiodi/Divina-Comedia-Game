extends Enemy
class_name ShadowEnemy

func _ready() -> void:
	super._ready()
	speedFix = 100
	groupsAdd()
	
func _process(delta: float) -> void:
	super._process(delta)
