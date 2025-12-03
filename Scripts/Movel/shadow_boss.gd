extends Enemy
class_name ShadowBoss

enum State  {
	DASH,
	SCRATCH,
	JUMP,
	IDLE
}

var actualAction : State

func setNewState() -> void:
	var keys = self.State.keys()
	var index = randi() % (keys.size() - 1)    # sorteia um índice
	
	if self.actualAction == index:
		setNewState()
		return
	self.actualAction = self.State[keys[index]]

func _process(delta: float) -> void:
	super._process(delta)
	
