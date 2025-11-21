extends Entity
class_name Player

#Dash ---------------
var dash : bool = true
var dashDuringDelay : float = 0.25
var dashDuringWait : float = self.dashDuringDelay
var dashSpeedMax : int = 4
var inDash : bool = false
var speedDash : int = 1

const INVLASTDASH : float = 0.1

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
var attackDelay : float = 0.5
var attackWait : float = self.attackDelay

const HITBOX_X := Vector2(64,96)
const HITBOX_Y := Vector2(96,64)

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

func _physics_process(delta: float) -> void:
	self.dashFunction(delta)
	super._physics_process(delta)

func _process(delta: float) -> void:
	super._process(delta)
	self.checkAttack(delta)
	self.scale = iniScale

func dashFunction(delta) -> void:
	var dashPress : bool = Input.is_action_just_pressed("space")
	
	#Começo o dash
	if dashPress && self.dash:
		self.inDash = true
		self.dashDuringWait = 0.0
		#cowdow do dash para usar denovo
		self.dash = false
		self.dashWait = 0.0
		game_manager.start_shake(1.0,1.5)
		self.lockDash = false
		self.invencibilityActivate(self.dashDuringDelay + 0.1)
	
	#Dando dash
	if self.dash:
		self.sprite.modulate = Color(0,1,0) #Verde
	else:
		if self.dashDuringWait < self.dashDuringDelay:
			self.dashDuringWait += delta
		else:
			self.inDash = false
	
	if self.inDash:
		self.speedDash = self.dashSpeedMax
		self.sprite.modulate = Color(1,0,0) #vermelho
	else:
		self.speedDash = 1
		if self.dashWait < self.dashDelay and !dash:
			self.dashWait += delta
			self.sprite.modulate = Color(0.6 + dashWait / 2 , 0.6 + dashWait / 2, 0) #amarelo
		else:
			self.dash = true
			self.dashWait = 0.0
		

func speedTarget() -> float:
	return super.speedTarget() * self.speedDash

func directionTarget(delta : float) -> void:
	if self.inDash:
		if !self.lockDash:
			self.lockDash = true
	else:
		self.direction = Input.get_vector("left", "right", "up", "down")
	
func groupsAdd() -> void:
	self.add_to_group("Player")
	self.groupRival = "Enemy"

func collidingRival(body) -> void:
	if self.inDash:
		self.invencibilityActivate(self.dashDuringDelay)
	super.collidingRival(body)

func AttackSucess(body : CharacterBody2D) -> void:
	super.AttackSucess(body)
	self.dashDuringWait -= 0.1
	self.direction = velocity.normalized()

func checkAttack(delta) -> void:
	if self.attack and Input.is_action_just_pressed("left_click"):
		if abs(self.lastDirection.x) >= abs(self.lastDirection.y):
			self.colHb.shape.size = self.HITBOX_X
			if self.lastDirection.x > 0:
				self.colHb.position = self.attRight.position
			else:
				self.colHb.position = self.attLeft.position
		else:
			self.colHb.shape.size = self.HITBOX_Y
			if self.lastDirection.y > 0:
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
			self.attackDuringWait += delta
		else:
			self.inAttack = false
			self.colHb.disabled = !self.inAttack
	else:
		if self.attackWait < self.attackDelay:
			self.attackWait += delta
		else:
			self.attack = true
