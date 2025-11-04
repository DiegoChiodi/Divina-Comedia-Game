extends Entity
class_name Player

#Dash ---------------
var dashMax : int = 3
var dash : int = dashMax
var dashDuringDelay : float = 0.2
var dashDuringWait : float = self.dashDuringDelay
var dashSpeedMax : int = 3

var dashDelay : float = 0.6
var dashWait : float = self.dashDelay
var dashPoss : bool = false # se é possivel dar dash
var lockDash : bool = false
@onready var sprite : ColorRect = $ColorRect
@onready var hbTake : Area2D = $are_hbTakeDamage
@onready var hbAttack : Area2D = $are_hbAttack

#direction

var inDash : bool = false
var speedDash : int = 1

func _ready() -> void:
	super._ready()
	damage = 20
	z_index = 1
func _physics_process(delta: float) -> void:
	self.dashFunction(delta)
	super._physics_process(delta)

func dashFunction(_delta) -> void:
	var attack : bool = Input.is_action_just_pressed("space") or Input.is_action_just_pressed("left_click")
	
	if attack && self.dash > 0:
		#Dando dash
		self.inDash = true
		self.dashDuringWait = 0.0
		#cowdow do dash para usar denovo
		self.dash -= 1
		self.dashWait = 0.0
		game_manager.start_shake(1.0,1.5)
	
	#Dando dash
	if self.dashDuringWait < self.dashDuringDelay:
		self.dashDuringWait += _delta
	else:
		self.inDash = false
		self.lockDash = false
	
	if self.dashWait < self.dashDelay:
		self.dashWait += _delta
		self.sprite.modulate = Color(0.6 + dashWait / 2 , 0.6 + dashWait / 2, 0) #amarelo
	elif dash < dashMax:
		self.dash += 1
		self.dashWait = 0.0
	
	if dash == dashMax:
		self.sprite.modulate = Color(0,1,0) #Verde
	
	if self.inDash:
		self.speedDash = dashSpeedMax
		self.sprite.modulate = Color(1,0,0) #vermelho
	else:
		self.speedDash = 1

func speedTarget() -> float:
	return super.speedTarget() * self.speedDash

func directionTarget(_delta : float) -> void:
	if self.inDash:
		if !self.lockDash:
			self.direction = (get_global_mouse_position() - self.global_position).normalized()
			self.lockDash = true
	else:
		self.direction = Input.get_vector("left", "right", "up", "down")
	
func groupsAdd() -> void:
	self.add_to_group("Player")
	self.groupRival = "Enemy"

func collidingRival(body) -> void:
	if self.inDash:
		invencibilityActivate()
	super.collidingRival(body)
