extends CharacterBody2D
class_name Movel

var move_direction : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO

var speed : float = 250 # Velocidade constante que guia movimento
var acceleration : float = 0.2  # Fator de suavização

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	directionTarget()

func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float) -> void:
	if self.direction != Vector2.ZERO:
		velocityTarget(delta)
	else:
		velocity = velocity.lerp(move_direction * 0, acceleration)
	
	move_and_slide()
	
func velocityTarget(delta) -> void:
	velocity = velocity.lerp(move_direction * speed, acceleration)

func directionTarget() -> void:
	pass

func move_directionTarget() -> void:
	self.move_direction = self.direction
