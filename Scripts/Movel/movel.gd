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

var impulseDelay : float =  1.0
var impulseWait : float = impulseDelay
var impulse : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	directionTarget(delta)
	impulseDir = impulseDir.lerp(Vector2.ZERO,acceleration)
	impulseDir = Vector2.ZERO
	rotationSet(delta)
	
	if direction != Vector2.ZERO:
		lastDirection = direction
	
	if impulseWait >= impulseDelay:
		impulse = false
	else:
		impulseWait += delta

func _physics_process(_delta: float) -> void:
	speed = speedTarget()
	move(_delta)

func move(_delta: float) -> void:
	var target_velocity = velocityTarget()

	# 1. Aceleração normal (input)
	if target_velocity != Vector2.ZERO:
		velocity = velocity.lerp(target_velocity, acceleration * _delta * 150)
	else:
		# Sem input → desaceleração
		velocity = velocity.lerp(Vector2.ZERO, acceleration)
	
	# 2. Movimento real
	var collision = move_and_collide(velocity * _delta)

	# 3. Física do ricochete
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func velocityTarget() -> Vector2:
	return velocity.lerp((direction * speed) + (impulseSpeed * impulseDir), acceleration)

func directionTarget(_delta : float) -> void:
	pass

func takeImpulseDir(_impulseDir : Vector2, _impulseSpeed : float = 1500) -> void:
	impulseDir = _impulseDir
	impulseSpeed = _impulseSpeed
	impulse = true
	impulseWait = 0.0

func speedTarget() -> float:
	return speedFix

func rotationSet(_delta) -> void:
	self.rotation = lerp_angle(self.rotation, (self.lastDirection).angle(), rotationSpeed * _delta)
