extends CharacterBody2D
class_name Movel

var move_direction : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var impulse : Vector2 = Vector2.ZERO
var impulseSpeed : float = 1.0

var speedFix : float = 250.0
var speed : float = self.speedFix # Velocidade constante que guia movimento
var acceleration : float = 0.2  # Fator de suavização

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	directionTarget(delta)
	impulse = impulse.lerp(Vector2.ZERO, acceleration)

func _physics_process(delta: float) -> void:
	speed = speedTarget()
	move(delta)

func move(delta: float) -> void:
	move_directionTarget(delta)
	
	if impulse.length() > 0.2:
		impulseSpeed = 0.8
	else:
		impulseSpeed = 1.0
	
	if self.move_direction != Vector2.ZERO:
		velocityTarget(delta)
	else:
		velocity = velocity.lerp(move_direction * 0, acceleration)
	
	move_and_slide()
	
func velocityTarget(delta : float) -> void:
	velocity = velocity.lerp(move_direction * speed, acceleration)

func directionTarget(delta : float) -> void:
	pass

func move_directionTarget(delta : float) -> void:
	self.move_direction = self.direction + impulse

func takeAttack(_impulse : Vector2, _damage : float = 0.0) -> void:
	takeImpulse(_impulse)

func takeImpulse(_impulse : Vector2) -> void:
	impulse = _impulse

func speedTarget() -> float:
	return speedFix * impulseSpeed
