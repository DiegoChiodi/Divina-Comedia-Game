extends AnimationEntity
class_name Player

#Dash ---------------
var dash : bool = true
var dashDuringDelay : float = 0.25
var dashDuringWait : float = self.dashDuringDelay
var dashSpeedMax : float = 3.5
var speedInDash : float = 1
var velocityInDash := Vector2.ZERO
var dashDir := Vector2.ZERO

var inDash : bool = false
const DASH_DELAY : float = 2.0
var dashWait : float = self.DASH_DELAY
var dashPoss : bool = false # se é possivel dar dash
const EXTEND_DASHS : int = 3
var actual_extend_dashs = 0
const DASH_SCALE_FEEL : float = 2.0
const DASH_SHRINK_DELAY : float = 0.1

const INVLASTDASH : float = 0.1
#inAAttack ----------------
var attack : bool = false
var inAttack : bool = false
#Tempo atacando
var attackDuringDelay : float = 0.25
var attackDuringWait : float = self.attackDuringDelay
#Tempo de espera para próximo ataque
var attackDelay : float = 0.25
var attackWait : float = self.attackDelay

const KNOCBACKSELFFEELING : float = 1000.0

#HITBOX size
const HITBOX_X := Vector2(96,80)
const HITBOX_Y := Vector2(80,96)

#Blink
var litghting : bool = false
const BLINKDELAYINIT : float = 0.25
var blinkDelay : float = self.BLINKDELAYINIT
var blinkWait : float = 0.0

#Sprite
var initial_scale : Vector2

@onready var hbTake : Area2D = $are_hbTakeDamage
@onready var hbAttack : Area2D = $are_hbAttack
@onready var colHb : CollisionShape2D = $are_hbAttack/CollisionShape2D
#Posições dos ataques
@onready var attRight : Marker2D = $Mark_right
@onready var attLeft : Marker2D = $Mark_left
@onready var attUp : Marker2D = $Mark_up
@onready var attDown : Marker2D = $Mark_down
#Sounds
@onready var sound_attack_1 : AudioStreamPlayer2D = $SndAttack1
@onready var sound_dash : AudioStreamPlayer2D = $SndDash

func _ready() -> void:
	super._ready()
	self.damage = 20
	self.z_index = 1
	self.colHb.disabled = true
	self.invencibleDelay = 1.5
	self.damageFlashDelay = 1.5
	self.speedFix = 300
	self.initial_scale = self.sprite.scale

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	self.dashFunction(_delta)

func _process(_delta: float) -> void:
	super._process(_delta)
	self.checkAttack(_delta)
	
	if self.inDash:
		self.sprite.play('dash')
		
	if Input.is_action_just_pressed("v"):
		self.speedFix = 500.0
		self.damage = 5000.0
	if Input.is_action_just_pressed("b"):
		self.speedFix = 300.0
		self.damage = 20.0
		self.life = self.lifeMax
	

func dashFunction(_delta) -> void:
	var right_click : bool = Input.is_action_just_pressed('right_click')
	var dashPress : bool = Input.is_action_just_pressed("space") or right_click
	
	#Começo o dash
	if dashPress && self.dash:
		self.dash_init(right_click)
	
	#Dash carregado
	if !self.dash:
		if self.dashDuringWait < self.dashDuringDelay:
			self.dashDuringWait += _delta
		else:
			self.inDash = false
			self.ricochet = self.inDash
	
	#Dando dash
	if self.inDash:
		self.impulseDir = Vector2.ZERO
		self.invencible = true
		if dashWait < self.DASH_SHRINK_DELAY:
			self.sprite.scale.y = lerp(self.sprite.scale.y,1.0 * self.initial_scale.y, 0.3)
	else:
		self.sprite.scale.y = self.initial_scale.y
		self.speedInDash = 1
		if self.dashWait < self.DASH_DELAY and !self.dash:
			self.dashWait += _delta
		elif !self.dash:#Carregou o dash
			self.dash = true
			self.sprite.scale.y = self.initial_scale.y
			self.dashWait = 0.0

func speedTarget() -> float:
	return super.speedTarget() * self.speedInDash

func directionTarget() -> void:
	var direction_target : Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction_target == Vector2.ZERO:
		self.direction = self.direction.lerp(Vector2.ZERO,0.2)
	else:
		self.direction = direction_target

func groupsAdd() -> void:
	self.add_to_group("Player")
	self.groupRival = "Enemy"

func AttackSucess(_body : CharacterBody2D) -> void:
	if self.inDash:
		self.dashDuringWait -= 0.1
		self.direction = velocity.normalized()
	
	var impDir : Vector2 = (self.position - _body.position).normalized()
	var finalImpDir : Vector2 = Vector2.ZERO
	if abs(impDir.x) >= abs(impDir.y):
		finalImpDir.x = impDir.x
	else:
		finalImpDir.y = impDir.y
		
	takeImpulse(finalImpDir, self.KNOCBACKSELFFEELING)

func velocityTarget(_delta : float) -> Vector2:
	if self.inDash:
		return self.velocity
	return super.velocityTarget(_delta)

func checkAttack(_delta) -> void:
	if self.attack and Input.is_action_just_pressed("left_click") and self.attackWait >= self.attackDelay and !self.inDash:
		var mouseDir : Vector2 = (get_global_mouse_position() - self.global_position).normalized()
		if abs(mouseDir.x) >= abs(mouseDir.y):
			self.colHb.shape.size = self.HITBOX_X
			if mouseDir.x > 0:
				self.colHb.position = self.attRight.position
			else:
				self.colHb.position = self.attLeft.position
		else:
			self.colHb.shape.size = self.HITBOX_Y
			if mouseDir.y > 0:
				self.colHb.position = self.attDown.position
			else:
				self.colHb.position = self.attUp.position
		self.inAttack = true
		self.colHb.disabled = !self.inAttack
		self.attackDuringWait = 0.0
		self.attackWait = 0.0
		self.sound_attack_1.play()

	#Está atacando
	if self.inAttack:
		if self.attackDuringWait < self.attackDuringDelay:
			self.attackDuringWait += _delta
		else:
			self.inAttack = false
			self.colHb.disabled = !self.inAttack
	else:
		if self.attackWait < self.attackDelay:
			self.attackWait += _delta
		else:
			self.attack = true

	var shape : Shape2D = self.colHb.shape
	var size = shape.size
	
		# Tamanho do debug
	$attack.size = size
	# Centralizar o ColorRect no CollisionShape
	$attack.position = self.colHb.position - size / 1.5
	$attack.visible = !self.colHb.disabled

func damageFlashing(_delta : float) -> void:
	if self.blinkWait > self.blinkDelay:
		self.blinkWait = 0.0
		self.litghting = !self.litghting
	else:
		self.blinkWait += _delta 
	
	self.blinkDelay += _delta / 5
	if self.litghting:
		self.modulate.a = lerp(self.modulate.a, 1.0, 0.05)
	else:
		self.modulate.a = lerp(self.modulate.a, 0.2, 0.1)
	
	Engine.time_scale = lerp(Engine.time_scale,1.0, 0.02)
	self.neutralizingWait = 0.0

func stopFlashing(_delta : float) -> void:
	self.modulate.a = lerp(self.modulate.a, 1.0, 0.03)
	self.blinkDelay = self.BLINKDELAYINIT
	Engine.time_scale = lerp(Engine.time_scale,1.0, 0.04)

func takeDamage(_damage : float) -> void:
	super.takeDamage(_damage)
	if !self.is_dead:
		Engine.time_scale = 0.2

func run_x() -> void:
	if self.direction.x < 0:
		self.sprite.play("run_left")
	else:
		super.run_x()

func idle_x() -> void:
	if self.lastDirection.x < 0:
		self.sprite.play("idle_left")
	else:
		super.idle_x()

func dash_intangible_col() -> void:
	pass

func ricochetied(collision : KinematicCollision2D) -> void:
	super.ricochetied(collision)
	
	if self.actual_extend_dashs < self.EXTEND_DASHS:
		self.actual_extend_dashs += 1
		self.dashDuringWait -= 0.025 * self.actual_extend_dashs

func dash_init(right_click : bool) -> void:
	self.speedInDash = self.dashSpeedMax
	self.velocity *= self.speedInDash
	
	self.inDash = true
	self.ricochet = self.inDash
	#cowdow do dash para usar denovo
	self.dash = false
	self.dashWait = 0.0
	self.dashDuringWait = 0.0
	self.actual_extend_dashs = 0
	
	var inv_dash_t : float = self.dashDuringDelay + self.INVLASTDASH
	self.invencibleWait -= inv_dash_t
	
	#Animation
	game_manager.start_shake(1.0,1.5)
	self.sprite.scale.y = DASH_SCALE_FEEL * initial_scale.y
	
	if right_click:
		self.velocity = self.speedTarget() * (self.get_global_mouse_position() - self.global_position).normalized()
	self.sound_dash.play()

func move_method(_delta : float) -> void:
	if inDash:
		var collision : KinematicCollision2D = move_and_collide(self.velocity * _delta)
	
		if collision:
			if self.ricochet:
				self.ricochetied(collision)
				return
			
			var other = collision.get_collider()
			
			if !(other is Movel):
				return
			var dirForce := Vector2.ZERO
			var force : float = 0.0
			if abs(-collision.get_normal().x) > abs(-collision.get_normal().y):
				dirForce = Vector2(-collision.get_normal().x,0)
			else:
				dirForce = Vector2(0,-collision.get_normal().y)
				
			force = min(self.MINEXTERNALFORCE, self.velocity.length())
			other.add_central_force(dirForce * force)
	else:
		super.move_method(_delta)
