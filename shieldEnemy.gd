extends ConfuseEnemy
class_name ShieldEnemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func checkCollidingRival() -> bool:
	if (rivalId == player and player != null and player.inDash):
		super.collidingRival()
	return false
