extends Node2D
class_name BossShadow

var radious : float

func _draw() -> void:
	draw_circle(Vector2.ZERO, self.radious, Color.BLACK)
