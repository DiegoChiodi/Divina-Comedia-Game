extends NavEnemy
class_name RangedEnemy

const SHOT_DELAY : float = 4.0
var shot_wait : float = 3.0
var projectile := preload('res://Scene/projectile.tscn')

func _ready() -> void:
	super._ready()
	self.speed = 100.0
	self.speedFix = 100.0
	self.lifeMax = 50.0
	self.life = self.lifeMax

func _process(_delta: float) -> void:
	super._process(_delta)
	if self.shot_wait < self.SHOT_DELAY:
		self.shot_wait += _delta
	else:
		self.shot_wait = randf_range(0.0,2.0)
		if seeingPlayer and game_manager.player != null:
			self.invencibilityActivate(false, 0.02)
			var projectile_add = self.projectile.instantiate()
			projectile_add.dir = (game_manager.player.position - self.position).normalized()
			projectile_add.position = self.position + (game_manager.player.position - self.position).normalized() * 10
			game_manager.roomContainer.currentRoom.call_deferred('add_child', projectile_add)
			self.takeImpulse((self.position - game_manager.player.position).normalized(), 750)

func setDirection() -> Vector2:
	if abs((game_manager.player.position - self.position).length()) > 500:
		return (game_manager.player.position - self.position).normalized()
	elif abs((game_manager.player.position - self.position).length()) < 300:
		return (self.position - game_manager.player.position).normalized()
	return Vector2.ZERO

func _on_tim_act_path_timeout() -> void:
	self.makepath()
