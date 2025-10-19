extends CharacterBody2D
class_name Movel

var direction : Vector2 = Vector2.ZERO
var impulseDir : Vector2 = Vector2.ZERO
var impulseSpeed : float = 1500.0
var lastDirection : Vector2 = Vector2.RIGHT

var speedFix : float = 250.0
var speed : float = self.speedFix # Velocidade constante que guia movimento
var acceleration : float = 0.2  # Fator de suavização
var rotationSpeed : float = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	directionTarget(delta)
	impulseDir = impulseDir.lerp(Vector2.ZERO,acceleration)
	rotationSet(delta)
	
	if direction != Vector2.ZERO:
		lastDirection = direction

func _physics_process(delta: float) -> void:
	speed = speedTarget()
	move(delta)

func move(delta: float) -> void:
	if self.direction != Vector2.ZERO or self.impulseDir != Vector2.ZERO:
		velocityTarget(delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, acceleration)
	
	move_and_slide()
	
func velocityTarget(delta : float) -> void:
	velocity = velocity.lerp((direction * speed) + (impulseSpeed * impulseDir), acceleration)

func directionTarget(delta : float) -> void:
	pass

func takeImpulseDir(_impulseDir : Vector2, _impulseSpeed : float = 1500) -> void:
	impulseDir = _impulseDir
	impulseSpeed = _impulseSpeed

func speedTarget() -> float:
	return speedFix

func rotationSet(delta) -> void:
	self.rotation = lerp_angle(self.rotation, (self.lastDirection).angle(), rotationSpeed * delta)
