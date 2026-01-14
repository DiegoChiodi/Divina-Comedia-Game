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
	var laugh_chosen : String
	var choice := randi() % 5

	match choice:
		0:
			laugh_chosen = "res://Assets/audio/sfx/enemy_laugh/creepy-laugh-2-401714.wav"
		1:
			laugh_chosen = "res://Assets/audio/sfx/enemy_laugh/evil-laugh-89423.wav"
		2:
			laugh_chosen = "res://Assets/audio/sfx/enemy_laugh/scary-laugh-377526.wav"
		3:
			laugh_chosen = "res://Assets/audio/sfx/enemy_laugh/gasp-242214.wav"
		4:
			laugh_chosen = "res://Assets/audio/sfx/enemy_laugh/female-sigh-450446.wav"

	var laugh_player := AudioStreamPlayer2D.new()
	laugh_player.stream = load(laugh_chosen)
	add_child(laugh_player)
	laugh_player.play()
	laugh_player.finished.connect(laugh_player.queue_free)
func takeDamage(_damage : float) -> void:
	super.takeDamage(_damage)
	self.body.modulate.a = min(life / lifeMax * 2, 0.8) 
	self.eyes.modulate.a = (lifeMax / life) / 8

func makepath() -> void:
	var player = game_manager.player
	if player != null:
		self.nav_agent.target_position = player.global_position
 
func setDirection() -> Vector2:
	return to_local(nav_agent.get_next_path_position()).normalized()

func _on_tim_act_path_timeout() -> void:
	self.makepath()
