extends Enemy
class_name ShadowBoss

enum State  {
	DASH,
	SCRATCH,
	JUMP,
	REST
}

var actualAction : State 
var lastAction : State

#Machine stats --------------------
#Rest ---------------
var timerRest := Timer.new() 
const RESTDURATION : float = 1.0

#Attack----------------------
var timerAttack := Timer.new() 
var attackSpeed : float = 1.0

#Dash ----------------
const DASHDURATION : float = 1.5
const DASHSPEED : float = 3.0

var dashDirection : Vector2 = Vector2.ZERO
var dash : bool = false
const DASHSMAXRANDOM : int = 3
var dashs : int = 0
#Jump ----------------
const JUMPDURATION : float = 3.0
const JUMPSPEEDMAX : float = 3.0
var jumpSpeed : float = 1.0
#Shadow
var shadow : BossShadow
const RADIOUSMAX : float  = 40.0
const RADIOUSMIN : float = 5.0
var shaRadious : float = self.RADIOUSMIN

const TRANSPARENCYINIT : float = 0.35
const TRANSPARENCYFINAL : float = 0.8

#Scratch ------------
const SCRATCHDURATION : float = 1.5

#Colisões
@onready var colTakeD : CollisionShape2D = $are_hbTakeDamage/CollisionShape2D
@onready var colAttack : CollisionShape2D = $are_hbAttack/CollisionShape2D
@onready var col : CollisionShape2D = $CollisionShape2D
#Sprites
@onready var enemy : Node2D = $Grafics/Enemy

func _ready() -> void:
	super._ready()
	
	self.shadow = BossShadow.new()
	add_child(self.shadow)
	
	self.lifeMax = 500.0
	self.life = self.lifeMax
	self.speedFix = 140.0
	self.loseScale = 0.02
	
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

func detectPlayer() -> void:
	super.detectPlayer()
	self.startDash()

func setNewState() -> void:
	var keys = State.keys() 
	
	var index = randi() % (keys.size() - 1)    # sorteia
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
			self.shadow.visible = true
			self.colTakeD.disabled = true
			self.colAttack.disabled = true
			self.col.disabled = true
			
			#Atualizando a sombra
			self.shaRadious = self.RADIOUSMIN
			self.shadow.modulate.a = self.TRANSPARENCYINIT
			self.shadow.radious = self.shaRadious
			self.shadow.queue_redraw()
			
			
		State.SCRATCH: #Start Scratch
			self.timerAttack.start(self.SCRATCHDURATION)
			self.attackSpeed = 1.5

func stateMachine(_delta : float) -> void:
	match self.actualAction:
		State.DASH:
			self.inDash()
		State.JUMP:
			self.inJump(_delta)
		State.SCRATCH:
			self.inScratch()
		State.REST:
			self.inRast()

func setRest() -> void:
	#Neutralizando o dash
	if self.dashs > 0:
		self.dashs -= 1
		startDash()
		return
	
	self.dash = false
	self.attackSpeed = 1.0 #null
	self.impulsionable = true
	#Neutralizando o pulo
	self.enemy.visible = true
	self.shadow.visible = false
	self.colTakeD.disabled = false
	self.colAttack.disabled = false
	self.col.disabled = false
	
	self.actualAction = State.REST
	self.timerRest.start()
func inDash() -> void:
	pass

func inJump(_delta : float) -> void:
	var seeingPlayer : bool = true
	if self.timerAttack.time_left < 0.6:
		self.attackSpeed = lerp(self.attackSpeed, 1.0, 0.98)
		self.shaRadious = lerp(self.shaRadious, self.RADIOUSMAX, 0.02)
		seeingPlayer = false
	else:
		self.shaRadious += 2 * _delta
	self.shadow.radious = self.shaRadious
	self.shadow.queue_redraw()
	self.shadow.modulate.a = move_toward(self.shadow.modulate.a, self.TRANSPARENCYFINAL, _delta / self.timerAttack.wait_time)

func inScratch() -> void:
	pass

func inRast() -> void:
	self.direction = Vector2.ZERO

func speedTarget() -> float:
	return super.speedTarget() * self.attackSpeed

func startDash() -> void:
	self.actualAction = State.DASH
	self.timerAttack.start(self.DASHDURATION)
	self.dashDirection = (game_manager.player.position - self.position).normalized()
	self.impulsionable = false
	self.attackSpeed = self.DASHSPEED
	self.direction = self.dashDirection

	if !self.dash:
		self.dashs = randi() % self.DASHSMAXRANDOM
		self.dash = true

func setDirection() -> Vector2:
	match self.actualAction:
		State.DASH:
			return self.direction
	
	return super.setDirection()
