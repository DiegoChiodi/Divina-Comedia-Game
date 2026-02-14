extends Path2D

@onready var flw_2d = $PathFollow2D
@onready var hand = get_hand()

func get_hand() -> ColorRect:
	for child in flw_2d.get_children():
		if child.is_in_group('hand'):
			return child
	return null

var speed : float = 100.0
var speed_init = 1000.0
var speed_finish = 100.0
var acceleration : float = 2.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.flw_2d.progress += self.speed * delta
	if self.flw_2d.progress_ratio < 0.7:
		self.speed = self.speed_init 
		self.hand.scale = lerp(self.hand.scale, Vector2.ONE * 2.5, self.acceleration * delta)
	else:
		if self.flw_2d.progress_ratio < 1.0:
			self.speed = lerp(self.speed, self.speed_finish, self.acceleration * delta)
		else:
			pass
		self.hand.scale = lerp(self.hand.scale, Vector2.ONE, self.acceleration * delta)
