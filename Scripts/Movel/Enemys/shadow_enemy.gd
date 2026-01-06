extends Enemy
class_name ShadowEnemy

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var tim_act_path := $tim_act_path as Timer

@onready var sprites := $sprites
@onready var body := $sprites/body
@onready var eyes := $sprites/eyes

func _ready() -> void:
	super._ready()
	self.speedFix = 150
	self.life = 80
	
	self.makepath()
	#Sprites
	self.eyes.flip_v = randi() % 2 == 0

func rotationSet(_delta) -> void:
	if seeingPlayer:
		self.sprites.rotation = lerp_angle(self.sprites.rotation, (self.lastDirection).angle() - 1.5, rotationSpeed * _delta)

func detectPlayer() -> void:
	super.detectPlayer()
	self.body.play('steap')

func takeDamage(_damage : float) -> void:
	super.takeDamage(_damage)
	self.body.modulate.a = min(life / lifeMax * 2, 0.8) 
	self.eyes.modulate.a = (lifeMax / life) / 8

func makepath() -> void:
	self.nav_agent.target_position = game_manager.player.global_position
 
func setDirection() -> Vector2:
	return to_local(nav_agent.get_next_path_position()).normalized()

func _on_tim_act_path_timeout() -> void:
	self.makepath()
