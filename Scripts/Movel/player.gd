extends Entity
class_name Player

#Dash ---------------
var dash : bool = true
var dashDuringDelay : float = 0.25
var dashDuringWait : float = self.dashDuringDelay
var dashSpeedMax : float = 3.5
var speedInDash : float = 1
var velocityInDash := Vector2.ZERO
var dashDir := Vector2.ZERO

const INVLASTDASH : float = 0.1

var inDash : bool = false
var dashDelay : float = 2
var dashWait : float = self.dashDelay
var dashPoss : bool = false # se é possivel dar dash
var lockDash : bool = false
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

@onready var sprite : ColorRect = $ColorRect
@onready var hbTake : Area2D = $are_hbTakeDamage
@onready var hbAttack : Area2D = $are_hbAttack
@onready var colHb : CollisionShape2D = $are_hbAttack/CollisionShape2D
#Posições dos ataques
@onready var attRight : Marker2D = $Mark_right
@onready var attLeft : Marker2D = $Mark_left
@onready var attUp : Marker2D = $Mark_up
@onready var attDown : Marker2D = $Mark_down

func _ready() -> void:
	super._ready()
	self.damage = 20
	self.z_index = 1
	self.colHb.disabled = true
	self.invencibleDelay = 1.5
	self.damageFlashDelay = 1.5

func _physics_process(_delta: float) -> void:
	self.dashFunction(_delta)
	super._physics_process(_delta)

func _process(_delta: float) -> void:
	super._process(_delta)
	self.checkAttack(_delta)
	self.scale = self.iniScale
	
	if Input.is_action_just_pressed("v"):
		self.speedFix = 1000.0
		self.damage = 5000.0
	if Input.is_action_just_pressed("b"):
		self.speedFix = 250.0
		self.damage = 20.0
		self.life = self.lifeMax

func dashFunction(_delta) -> void:
	var right_click : bool = Input.is_action_just_pressed('right_click')
	var dashPress : bool = Input.is_action_just_pressed("space") or right_click
	
	#Começo o dash
	if dashPress && self.dash:
		self.speedInDash = self.dashSpeedMax
		self.velocity *= self.speedInDash
		
		self.inDash = true
		self.ricochet = self.inDash
		#cowdow do dash para usar denovo
		self.dash = false
		self.dashWait = 0.0
		self.dashDuringWait = 0.0
		
		game_manager.start_shake(1.0,1.5)
		self.lockDash = false
		self.invencibilityActivate(false)
		if right_click:
			self.velocity = self.speedTarget() * (self.get_global_mouse_position() - self.global_position).normalized()
		
	#Dash carregado
	if self.dash:
		self.sprite.modulate = Color(0,1,0) #Verde
	else:
		if self.dashDuringWait < self.dashDuringDelay:
			self.dashDuringWait += _delta
		else:
			self.inDash = false
			self.ricochet = self.inDash
	
	#Dando dash
	if self.inDash:
		self.sprite.modulate = Color(1,0,0) #vermelho
		self.impulseDir = Vector2.ZERO
	else:
		self.speedInDash = 1
		if self.dashWait < self.dashDelay and !self.dash:
			self.dashWait += _delta
			self.sprite.modulate = Color(0.6 + self.dashWait / 2 , 0.6 + self.dashWait / 2, 0) #amarelo
		else:
			self.dash = true
			self.dashWait = 0.0

func speedTarget() -> float:
	return super.speedTarget() * self.speedInDash

func directionTarget() -> void:
	self.direction = Input.get_vector("left", "right", "up", "down")


func groupsAdd() -> void:
	self.add_to_group("Player")
	self.groupRival = "Enemy"

func collidingRival(_body) -> void:
	super.collidingRival(_body)

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
		
	takeImpulseDir(finalImpDir, self.KNOCBACKSELFFEELING)

func velocityTarget() -> Vector2:
	if self.inDash:
		return self.velocity
	return super.velocityTarget()

func checkAttack(_delta) -> void:
	if self.attack and Input.is_action_just_pressed("left_click") and self.attackWait >= self.attackDelay:
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

func stopFlashing(_delta : float) -> void:
	self.modulate.a = lerp(self.modulate.a, 1.0, 0.03)
	self.blinkDelay = self.BLINKDELAYINIT
