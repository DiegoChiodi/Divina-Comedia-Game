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
#Dash ------------------
#Timer
var timerAttack := Timer.new() 
const DASHDURATION : float = 1.5
var dashs : int = 0

const SPEEDDASHMAX : float = 3.0
var speedDash : float = 0.0
var dashDirection : Vector2 = Vector2.ZERO
var dash : bool = false
const DASHSMAXRANDOM : int = 3
#Rest -----------------
var timerRest := Timer.new() 
const RESTDURATION : float = 1.0

#Jump ----------------
const JUMPDURATION : float = 4.0

#Scratch ------------
const SCRATCHDURATION : float = 1.5




#Colisões
@onready var colTakeD : CollisionShape2D = $are_hbTakeDamage/CollisionShape2D
@onready var colAttack : CollisionShape2D = $are_hbAttack/CollisionShape2D
@onready var col : CollisionShape2D = $CollisionShape2D
#Sprites
@onready var enemy : Node2D = $Grafics/Enemy
@onready var shadow : Node2D = $Grafics/Shadow

func _ready() -> void:
	super._ready()
	
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
	self.stateMachine()

func detectPlayer() -> void:
	super.detectPlayer()
	self.startDash()

func setNewState() -> void:
	var keys = State.keys() 
	
	var index = randi() % (keys.size() - 1)    # sorteia
	if self.lastAction == index:
		self.setNewState()
		return
	
	self.actualAction = State.JUMP #State[keys[index]]
	self.lastAction = self.actualAction
	
	match self.actualAction:
		State.DASH: #Start dash
			if game_manager.player != null:
				startDash()
		State.JUMP: #Start jump
			self.timerAttack.start(self.JUMPDURATION)
			
			self.enemy.visible = false
			self.shadow.visible = true
			self.colTakeD.disabled = true
			self.colAttack.disabled = true
			self.col.disabled = true
			
		State.SCRATCH: #Start Scratch
			self.timerAttack.start(self.SCRATCHDURATION)

func stateMachine() -> void:
	match self.actualAction:
		State.DASH:
			self.inDash()
		State.JUMP:
			self.inJump()
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
	self.speedDash = 1.0 #null
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
	self.speedDash = self.SPEEDDASHMAX
	self.direction = self.dashDirection

func inJump() -> void:
	self.visible = true

func inScratch() -> void:
	pass

func inRast() -> void:
	self.direction = Vector2.ZERO

func speedTarget() -> float:
	return super.speedTarget() * self.speedDash

func startDash() -> void:
	self.actualAction = State.DASH
	self.timerAttack.start(self.DASHDURATION)
	self.dashDirection = (game_manager.player.position - self.position).normalized()
	self.impulsionable = false
	
	if !self.dash:
		self.dashs = randi() % self.DASHSMAXRANDOM
		self.dash = true
