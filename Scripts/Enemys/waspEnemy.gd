extends Enemy
class_name WaspEnemy

var perseguition : Array[Vector2] = []
var disPerDelay : float = 0.2
var disPerWait : float = disPerDelay
var secondsDis : int = 1
var posTarget : Vector2 = Vector2.ZERO

func _ready() -> void:
	super._ready()
	speedFix *= 0.9
	
func _process(delta: float) -> void:
	super._process(delta)
	
	if disPerWait > disPerDelay and player != null:
		disPerWait = 0.0
		perseguition.append(player.position)
		if perseguition.size() > secondsDis:
			posTarget = perseguition.pop_front()
			print(posTarget)
			print(player.position)
	else:
		disPerWait += delta

func directionTarget(delta : float) -> void:
	direction = (posTarget - self.position).normalized()
