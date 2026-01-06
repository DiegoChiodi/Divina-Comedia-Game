extends Obstacle
class_name plate

var written_sprite : int = randi() % 4

func _ready() -> void:
	var posRect = Vector2.ZERO
	match (self.written_sprite):
		1:
			posRect = Vector2(16,0)
		2:
			posRect = Vector2(0,16)
		3:
			posRect = Vector2(16,16)
	
	self.sprite.region_rect = Rect2(posRect, Vector2(16,16))
	print(self.written_sprite)
