extends Enemy
class_name ConfuseEnemy

var perseguition : float = 0.02
var flip_scale_x : float = 1.0
var default_scale : Vector2
@onready var sprite : AnimatedSprite2D = $sprite
var in_ani_speed : bool = false

func _ready() -> void:
	super._ready()
	self.speedFix = 500.0
	self.life = 70.0
	if self.sprite != null:
		self.default_scale = self.sprite.scale
	
func setDirection() -> Vector2:
	return lerp(self.direction, (game_manager.player.position - self.position).normalized(), self.perseguition)

func takeDamage(_damage : float) -> void:
	super.takeDamage(_damage)
	self.direction *= 0.3
	
	self.feel_damage()

func _process(_delta: float) -> void:
	super._process(_delta)
	self.flip_sprite(_delta)

func flip_sprite(_delta : float) -> void:
	var dir_angle = abs(int(rad_to_deg(self.direction.angle())) % 360)
	if (dir_angle + 90) % 360 >= 180:
		self.flip_scale_x = lerp(self.flip_scale_x, -1.0, 8 * _delta)
	else:
		self.flip_scale_x = lerp(self.flip_scale_x, 1.0, 8 *_delta)
	self.sprite.scale.x = self.default_scale.x * self.flip_scale_x
	
	
	if self.velocity.length() < 350:
		if self.in_ani_speed:
			self.sprite.play("slow")
			self.in_ani_speed = false
	else:
		if !self.in_ani_speed:
			self.sprite.play("fast")
			self.in_ani_speed = true
	
func feel_damage() -> void:
	pass
