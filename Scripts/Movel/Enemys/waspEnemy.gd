extends Enemy
class_name WaspEnemy

var persecution : Array[Vector2] = []
var disPerDelay : float = 0.05
var disPerWait : float = self.disPerDelay
var secondsDis : int = 4
var posTarget : Vector2 = Vector2.ZERO

func _ready() -> void:
	super._ready()
	self.speedFix *= 0.9
	
func _process(delta: float) -> void:
	super._process(delta)
	
	if self.disPerWait > self.disPerDelay and game_manager.player != null:
		self.disPerWait = 0.0
		self.persecution.append(game_manager.player.position)
		if self.persecution.size() > self.secondsDis:
			self.posTarget = self.persecution.pop_front()
	else:
		self.disPerWait += delta

func setDirection() -> Vector2:
	return (self.posTarget - self.position).normalized()
