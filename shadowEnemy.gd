extends Enemy
class_name ShadowEnemy

func _ready() -> void:
	super._ready()
	speedFix = 100
	groupsAdd()
	
func _process(delta: float) -> void:
	super._process(delta)
	if colPlayer:
		self.player.takeAttack((self.player.position - self.position).normalized() * 3, damage)
		self.takeImpulse((self.position - self.player.position).normalized() * 3)
		if self.player.inDash:
			pass

func groupsAdd() -> void:
	pass
