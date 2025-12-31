extends Entity
class_name AnimationEntity

var sprite : AnimatedSprite2D
var lastDirectionX : float = 0

func _ready() -> void:
	super._ready()
	set_sprite()
	
func _process(delta: float) -> void:
	super._process(delta)
	if self.lastDirection.x != 0:
		self.sprite.flip_h = false if self.lastDirection.x > 0 else true

func set_sprite() -> void:
	self.sprite = $sprite
	self.sprite.play()
