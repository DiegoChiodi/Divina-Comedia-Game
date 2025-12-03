extends Enemy
class_name ShadowBoss

enum State  {
	DASH,
	SCRATCH,
	JUMP,
	IDLE
}

var actualAction : State = State.IDLE

func _ready() -> void:
	super._ready()
	self.speedFix = 100.0

func _process(delta: float) -> void:
	super._process(delta)
	

func takeDamage(_damage : float) -> void:
	super.takeDamage(_damage)
	setNewState()

func setNewState() -> void:
	var keys = self.State.keys()
	for key in keys:
		print(key)
	
	var index = randi() % (keys.size() - 1)    # sorteia um índice -1 por causa do IDLE
	if self.actualAction == index:
		setNewState()
		return
	self.actualAction = self.State[keys[index]]

func detectPlayer() -> void:
	super.detectPlayer()
