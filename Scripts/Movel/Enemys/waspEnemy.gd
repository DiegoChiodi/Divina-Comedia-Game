extends Enemy
class_name WaspEnemy

var perseguition : Array[Vector2] = []
var disPerDelay : float = 0.05
var disPerWait : float = disPerDelay
var secondsDis : int = 4
var posTarget : Vector2 = Vector2.ZERO

func _ready() -> void:
	super._ready()
	self.speedFix *= 0.9
	
func _process(delta: float) -> void:
	super._process(delta)
	
	if self.disPerWait > self.disPerDelay and game_manager.player != null:
		self.disPerWait = 0.0
		self.perseguition.append(game_manager.player.position)
		if self.perseguition.size() > secondsDis:
			posTarget = perseguition.pop_front()
	else:
		self.disPerWait += delta

func setDirection() -> Vector2:
	return (self.posTarget - self.position).normalized()
