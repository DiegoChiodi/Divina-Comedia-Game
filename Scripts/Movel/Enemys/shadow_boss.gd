extends Enemy
class_name ShadowBoss

enum State  {
	DASH,
	JUMP,
	SCRATCH,
	REST
}

var actualAction : State 
var lastAction : State

#Machine stats --------------------
#Rest ---------------
var timerRest := Timer.new() 
const RESTDURATION : float = 1.5

#Attack----------------------
var timerAttack := Timer.new() 
var attackSpeed : float = 1.0

#Dash ----------------
const DASHDURATION : float = 1.5
const DASHSPEED : float = 4.0

var dashDirection : Vector2 = Vector2.ZERO
var dash : bool = false
const DASHSMAXRANDOM : int = 3
var dashs : int = 0
#Jump ----------------
const JUMPDURATION : float = 2.25
const JUMPSPEEDMAX : float = 3.5
var jumpSpeed : float = 1.0

#Scratch ------------
const SCRATCHDURATION : float = 1.0
const SCRATCHSPEED : float = 0.0

#Dead -------------------
const TRANSPARENCYINIT : float = 0.35
const TRANSPARENCYFINAL : float = 0.8
const TRADE_TIME : float = 2.0
var trade_turn_wait : float = 0.0
const DEAD_DELAY : float = 3.0
var pos_dead : Vector2 = Vector2.ZERO
var TREMENDOUS : float = 5.0
#Shadow
var shadowBoss : CircleDraw
const RADIOUSMAX : float  = 40.0
const RADIOUSMIN : float = 5.0
var shaRadious : float = self.RADIOUSMIN
var control_shadows : Node2D = Node2D.new()
var cor_turn : ColorRect = ColorRect.new()

#Colisões
@onready var colTakeD : CollisionShape2D = $are_hbTakeDamage/CollisionShape2D
@onready var colAttack : CollisionShape2D = $are_hbAttack/CollisionShape2D
@onready var areAttack : Area2D = $are_hbAttack
@onready var col : CollisionShape2D = $CollisionShape2D
@onready var areScratch : Area2D = $are_scratch
@onready var colScratch : CollisionShape2D = self.areScratch.get_node("col_scratch")
@onready var recScratch : ColorRect = self.areScratch.get_node("rec_scratch")

#Sprites
@onready var enemy : Node2D = $Grafics/Enemy
@onready var healfhBar : ColorRect = enemy.get_node('actualHelfhbar')
@onready var spr_boss_bar : Sprite2D = Sprite2D.new()
#Sounds
@onready var sfx_roar : AudioStreamPlayer2D = $Sfx_roar
@onready var sfx_dead : AudioStreamPlayer2D = $Sfx_dead
@onready var sfx_scratch : AudioStreamPlayer2D = $Sfx_scratch

func _ready() -> void:
	super._ready()
	
	#Sprite
	self.spr_boss_bar.texture = load("res://Assets/sprites/boss-bar.png")
	
	self.lifeMax = 500.0
	self.life = self.lifeMax
	self.speedFix = 140.0
	
	self.shadowBoss = CircleDraw.new()
	add_child(self.shadowBoss)
	self.colScratch.disabled = true
	self.recScratch.visible = false
	
	self.timerAttack.timeout.connect(self.setRest)
	self.timerAttack.one_shot = true
	self.timerAttack.wait_time = self.DASHDURATION
	add_child(self.timerAttack)
		
	self.timerRest.timeout.connect(self.setNewState)
	self.timerRest.one_shot = true
	self.timerRest.wait_time = self.RESTDURATION
	add_child(self.timerRest)

func _process(_delta: float) -> void:
	super._process(_delta)
	self.stateMachine(_delta)
	if self.seeingPlayer:
		if self.trade_turn_wait < self.TRADE_TIME:
			trade_turn_wait += _delta
			
			self.cor_turn.modulate.a = move_toward(self.cor_turn.modulate.a, 0.5, _delta)
			#self.cor_turn.modulate.g = move_toward(self.cor_turn.modulate.g, 0.2, _delta)
			#self.cor_turn.modulate.b = move_toward(self.cor_turn.modulate.b, 0.2, _delta)
		
		var viewport_rect := get_viewport().get_visible_rect()
		
		var cam_zoom := game_manager.camera.zoom
		var cam_size := viewport_rect.size * cam_zoom
		var cam_position := game_manager.camera.global_position - cam_size / 2
		
		self.cor_turn.position = cam_position + cam_size * 1.5
		self.cor_turn.size = cam_size * 2
		
		self.spr_boss_bar.position = cam_position + Vector2(cam_size.x / 2, cam_size.y - cam_size.y / 10)

func detectPlayer() -> void:
	super.detectPlayer()
	self.startDash()
	self.sfx_roar.play()
	self.cor_turn.modulate = Color.BLACK
	get_parent().add_child(self.cor_turn)
	get_parent().add_child(self.spr_boss_bar)
	self.cor_turn.z_index = 10
	self.spr_boss_bar.scale *= 5

func setNewState() -> void:
	var keys = State.keys() 
	var playerExi : bool = game_manager.player != null
	
	var index = randi() % (keys.size() - 1)    # sorteia
	
	if playerExi and self.position.distance_to(game_manager.player.position) < 250 and self.lastAction != State.SCRATCH:
		index = State.SCRATCH
	
	if self.lastAction == index:
		self.setNewState()
		return
	
	self.actualAction = State[keys[index]]
	self.lastAction = self.actualAction
	
	match self.actualAction:
		State.DASH: #Start dash
			if game_manager.player != null:
				startDash()
		State.JUMP: #Start jump
			self.timerAttack.start(self.JUMPDURATION)
			
			self.attackSpeed = self.JUMPSPEEDMAX
			#Desativando visibildade e colisões
			self.enemy.visible = false
			self.shadowBoss.visible = true
			self.colTakeD.disabled = true
			self.colAttack.disabled = true
			self.col.disabled = true
			
			#Atualizando a sombra
			self.shaRadious = self.RADIOUSMIN
			self.shadowBoss.modulate.a = self.TRANSPARENCYINIT
			self.shadowBoss.radious = self.shaRadious
			self.shadowBoss.queue_redraw()
			
			
		State.SCRATCH: #Start Scratch
			self.timerAttack.start(self.SCRATCHDURATION)
			self.attackSpeed = self.SCRATCHSPEED
			if game_manager.player != null:
				self.areScratch.rotation =  (game_manager.player.position - self.position).angle() + 1.5
			self.colScratch.disabled = false
			self.recScratch.visible = true
			self.sfx_scratch.play()

func stateMachine(_delta : float) -> void:
	match self.actualAction:
		#State.DASH: #self.inDash()
		State.JUMP: self.inJump(_delta)
		State.SCRATCH: self.inScratch(_delta)
		State.REST: self.inRast()

func setRest() -> void:
	match self.lastAction: #Neutralizando o dash
		State.DASH:
			if self.dashs > 0:
				startDash()
				return
			self.dash = false
		State.JUMP: #Neutralizando o pulo
			self.enemy.visible = true
			self.shadowBoss.visible = false
			self.colTakeD.disabled = false
			self.colAttack.disabled = false
			if !self.bodysCol.is_empty():
				for body in bodysCol:
					body.checkColliding()
			self.col.disabled = false
		State.SCRATCH: #Neutralizando  scratch
			self.colScratch.disabled = true
			self.recScratch.visible = false
	#Neutralizando tudo
	self.attackSpeed = 1.0 #null
	self.impulsionable = true
	self.actualAction = State.REST
	self.timerRest.start()

func inJump(_delta : float) -> void:
	if self.timerAttack.time_left < 0.6:
		self.attackSpeed = lerp(self.attackSpeed, 1.0, 0.98)
		self.shaRadious = lerp(self.shaRadious, self.RADIOUSMAX, 0.02)
	else:
		self.shaRadious += 2 * _delta
	
	if self.timerAttack.time_left < 0.05:
		self.colAttack.disabled = false
		
	self.shadowBoss.radious = self.shaRadious
	self.shadowBoss.queue_redraw()
	self.shadowBoss.modulate.a = move_toward(self.shadowBoss.modulate.a, self.TRANSPARENCYFINAL, _delta / self.timerAttack.wait_time)

func inScratch(_delta : float) -> void:
	self.areScratch.rotation -= _delta * 3.0

func inRast() -> void:
	self.direction = Vector2.ZERO

func speedTarget() -> float:
	return super.speedTarget() * self.attackSpeed

func startDash() -> void:
	self.actualAction = State.DASH
	self.timerAttack.start(self.DASHDURATION)
	if game_manager.player != null:
		self.dashDirection = (game_manager.player.position - self.position).normalized()
	self.impulsionable = false
	self.attackSpeed = self.DASHSPEED
	self.direction = self.dashDirection

	if self.dash:
		self.dashs -= 1
	else:
		self.dashs = randi() % self.DASHSMAXRANDOM
		self.dash = true

func setDirection() -> Vector2:
	match self.actualAction:
		State.DASH:
			return self.direction
	
	return super.setDirection()

func takeAttack(_impulseDir : Vector2, _damage : float = 0.0, _impulseSpeed : float = 1200) -> void:
	super.takeAttack(_impulseDir, _damage, _impulseSpeed)
	self.healfhBar.scale.y = self.life / self.lifeMax

func dead () -> void:
	super.dead()
	self.trade_turn_wait = 0.0
	self.pos_dead = self.position
	self.setRest()
	self.control_shadows.position = self.global_position
	get_parent().add_child(self.control_shadows)
	self.sfx_dead.play()

func dying(_delta : float) -> void:
	if self.trade_turn_wait < self.DEAD_DELAY:
		self.setRest()
		#Mudar o tempo
		self.trade_turn_wait += _delta
		var parent := self.get_parent()
		self.cor_turn.modulate.a = move_toward(self.cor_turn.modulate.a, 0.0, _delta)
		#Tremedeira
		var pos_sort : Vector2 = Vector2(randf_range(-self.TREMENDOUS,self.TREMENDOUS),randf_range(-self.TREMENDOUS,self.TREMENDOUS))
		self.position = pos_sort + self.pos_dead
		#Sombras saindo
		for i in range(3):
			var shadow_new : CircleDraw = CircleDraw.new()
			shadow_new.speed = Vector2(randf_range(-300,300),randf_range(-300,300))
			shadow_new.position = shadow_new.speed / 4
			shadow_new.radious = randf_range(4,12)
			parent.shadows.append(shadow_new)
			self.control_shadows.add_child(shadow_new)
	else:
		super.dying(_delta)
