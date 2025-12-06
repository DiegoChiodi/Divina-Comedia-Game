extends Node2D

const RADIOUSMAX : float  = 300.0
const RADIOUSMIN : float = 30.0
var radious : float = self.RADIOUSMIN

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	draw_circle(Vector2.ZERO, radious, Color.BLACK)
