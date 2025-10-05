extends Entity
class_name Player

#Dash ---------------
var dashDuringDelay : float = 0.2
var dashDuringWait : float = self.dashDuringDelay

var dashDelay : float = 1.0
var dashWait : float = self.dashDelay
var dashPoss : bool = false # se é possivel dar dash
@onready var sprite : ColorRect = $ColorRect

var inDash : bool = false
var speedDash : int = 1

func _physics_process(delta: float) -> void:
	self.dash(delta)
	super.move(delta)

func dash(delta) -> void:
	var attack : bool = Input.is_action_just_pressed("space") or Input.is_action_just_pressed("left_click")
	
	if attack && dashPoss:
		#Dando dash
		self.inDash = true
		self.dashDuringWait = 0.0
		#cowdow do dash para usar denovo
		self.dashPoss = false
		self.dashWait = 0.0
	
	if self.dashDuringWait < self.dashDuringDelay:
		self.dashDuringWait += delta
	else:
		self.inDash = false
	
	if self.dashWait < self.dashDelay:
		self.dashWait += delta
		self.sprite.modulate = Color(1,1,0)
	else:
		self.dashPoss = true
		self.sprite.modulate = Color(0,1,0)
	
	if self.inDash:
		self.speedDash = 3
		self.sprite.modulate = Color(1,0,0)
	else:
		self.speedDash = 1

func velocityTarget(delta) -> void:
	velocity = velocity.lerp(move_direction * speed * speedDash, acceleration)

func directionTarget() -> void:
	self.direction = Input.get_vector("left", "right", "up", "down")
	
func groupsAdd() -> void:
	add_to_group("Player")
	groupRival = "Enemy"

func move_directionTarget() -> void:
	if inDash:
		move_direction = (get_global_mouse_position() - self.global_position).normalized()
	else:
		super.move_directionTarget()
