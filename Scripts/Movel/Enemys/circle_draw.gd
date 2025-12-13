extends Node2D
class_name CircleDraw

var radious : float
var speed : Vector2

func _draw() -> void:
	draw_circle(Vector2.ZERO, self.radious, Color.BLACK)

func move(_delta : float) -> void:
	self.position += self.speed * _delta
	self.queue_redraw()
	self.radious = lerp(self.radious,0.0,0.02)
