extends Node2D
class_name Obstacle

@onready var colHb : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D
var lessing : float = 5
var dir : Vector2
var dirFalling : Vector2
var forceImpact : float
var breaked : bool = false
var falling : bool = false
var fallingLissing : float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.forceImpact = lerp(self.forceImpact, 0.0, self.lessing * delta)
	self.position += self.forceImpact * self.dir * delta
	
	if !self.breaked:
		return
	
	if !self.falling:
		self.dirFalling = self.dir
	
	if self.dirFalling.x > 0:
		self.rotation_degrees = lerp(self.rotation_degrees, 90.0, self.fallingLissing * delta)
	else:
		self.rotation_degrees = lerp(self.rotation_degrees, -90.0, self.fallingLissing * delta)


func _on_area_2d_area_entered(area: Area2D) -> void:
	self.dir = (self.global_position - area.get_parent().global_position).normalized()
	self.forceImpact = 80.0
	if self.breaked:
		self.falling = true
	else:
		self.breaked = true
