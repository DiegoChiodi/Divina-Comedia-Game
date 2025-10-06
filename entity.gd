extends Movel
class_name Entity

var lifeMax : float = 100
var life : float = lifeMax
var damage : float = 20

var groupRival : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	groupsAdd()

func _process(delta: float) -> void:
	super._process(delta)
	if life <= 0:
		self.queue_free()

func groupsAdd() -> void:
	pass

func takeDamage(_damage : float) -> void:
	life -= damage

func takeAttack(_damage : float, _impulse : Vector2):
	takeDamage(_damage)
	takeImpulse(_impulse)

func dead() -> void:
	pass
