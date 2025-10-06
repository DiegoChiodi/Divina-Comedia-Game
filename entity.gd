extends Movel
class_name Entity

var lifeMax : float = 100
var life : float = lifeMax
var damage : float = 20

var invencible : bool = false
var invencibleDelay : float = 0.2
var invencibleWait : float = self.invencibleDelay

var groupRival : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	groupsAdd()

func _process(delta: float) -> void:
	super._process(delta)
	if life <= 0:
		self.queue_free()
	
	if self.invencible:
		if invencibleWait < invencibleDelay:
			invencibleWait += delta
		else:
			invencible = false
	
func groupsAdd() -> void:
	pass

func takeDamage(_damage : float) -> void:
	if !invencible:
		life -= damage
		invencible = true
		invencibleWait = 0.0

func takeAttack(_impulse : Vector2, _damage : float):
	super.takeAttack(_impulse, _damage)
	takeDamage(_damage)
	
	

func dead() -> void:
	pass
