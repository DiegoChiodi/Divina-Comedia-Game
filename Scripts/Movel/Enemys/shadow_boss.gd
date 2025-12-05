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
var speedDash : float = 4.0
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

func _process(delta: float) -> void:
	super._process(delta)
	self.stateMachine()

func setNewState() -> void:
	var keys = State.keys() 
	
	var index = randi() % (keys.size() - 1)    # sorteia
	if self.lastAction == index:
		self.setNewState()
		return
	
	self.actualAction = State[keys[index]]
	self.lastAction = self.actualAction
	match self.actualAction:
		State.DASH:
			if game_manager.player != null:
				startDash()
		State.JUMP:
			self.timerAttack.start(self.JUMPDURATION)
		State.SCRATCH:
			self.timerAttack.start(self.SCRATCHDURATION)

func detectPlayer() -> void:
	super.detectPlayer()
	self.startDash()

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
	if self.dashs > 0:
		self.dashs -= 1
		startDash()
		return
	
	self.speedDash = 1.0 #null
	self.actualAction = State.REST
	self.timerRest.start()
	self.dash = false
	self.impulsionable = true

func inDash() -> void:
	self.speedDash = self.SPEEDDASHMAX
	self.direction = self.dashDirection

func inJump() -> void:
	pass

func inScratch() -> void:
	pass

func inRast() -> void:
	self.direction = Vector2.ZERO

func speedTarget() -> float:
	return super.speedTarget() * self.speedDash

func startDash() -> void:
	self.actualAction = State.DASH
	self.timerAttack.start(DASHDURATION)
	self.dashDirection = (game_manager.player.position - self.position).normalized()
	self.impulsionable = false
	
	if !self.dash:
		self.dashs = randi() % self.DASHSMAXRANDOM
		self.dash = true
	print(dashs)
