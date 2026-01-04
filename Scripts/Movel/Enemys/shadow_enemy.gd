extends Enemy
class_name ShadowEnemy

func _ready() -> void:
	super._ready()
	self.speedFix = 150
	self.life = 80
	$body_sprites/eyes.flip_v = randi() % 2 == 0

func rotationSet(_delta) -> void:
	if seeingPlayer:
		$body_sprites.rotation = lerp_angle($body_sprites.rotation, (self.lastDirection).angle() - 1.5, rotationSpeed * _delta)

func detectPlayer() -> void:
	super.detectPlayer()
	$body_sprites/sprite.play('steap')

func takeDamage(_damage : float) -> void:
	super.takeDamage(_damage)
	$body_sprites/sprite.modulate.a = min(life / lifeMax * 2, 0.8) 
	$body_sprites/eyes.modulate.a = (lifeMax / life) / 8
