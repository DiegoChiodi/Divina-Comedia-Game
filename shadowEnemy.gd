extends Enemy
class_name ShadowEnemy

var colPlayer : bool = false

func _ready() -> void:
	super._ready()
	groupsAdd()
	
func _process(delta: float) -> void:
	super._process(delta)
	if colPlayer:
		self.player.takeImpulse((self.player.position - self.position).normalized() * 3)
		self.takeImpulse((self.position - self.player.position).normalized() * 3)
		if self.player.inDash:
			pass

func _on_col_hb_attack_area_entered(area: Area2D) -> void:
	if area.get_parent() == player:
		colPlayer = true

func _on_col_hb_attack_area_exited(area: Area2D) -> void:
	if area.get_parent() == player:
		colPlayer = false

func groupsAdd() -> void:
	pass
