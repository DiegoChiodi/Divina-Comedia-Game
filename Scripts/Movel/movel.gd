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
	self.impulseDir = self.impulseDir.lerp(Vector2.ZERO, self.acceleration)
	self.impulseDir = Vector2.ZERO
	rotationSet(delta)
	
	if direction != Vector2.ZERO:
		self.lastDirection = direction
	
	if self.impulseWait >= self.impulseDelay:
		self.impulse = false
	else:
		self.impulseWait += delta

func _physics_process(_delta: float) -> void:
	speed = speedTarget()
	move(_delta)

func move(_delta: float) -> void:
	var target_velocity = velocityTarget()

	# 1. Aceleração normal (input)
	if target_velocity != Vector2.ZERO:
		self.velocity = self.velocity.lerp(target_velocity, self.acceleration * _delta * 200)
	else:
		# Sem input → desaceleração
		self.velocity = velocity.lerp(Vector2.ZERO, self.acceleration)
	
	# 2. Movimento real
	var collision = move_and_collide(self.velocity * _delta)

	# 3. Física do ricochete
	if collision:
		self.velocity = self.velocity.bounce(collision.get_normal())

func velocityTarget() -> Vector2:
	return velocity.lerp((direction * speed) + (impulseSpeed * impulseDir), acceleration)

func directionTarget(_delta : float) -> void:
	pass

func takeImpulseDir(_impulseDir : Vector2, _impulseSpeed : float = 1500) -> void:
	self.impulseDir = _impulseDir
	self.impulseSpeed = _impulseSpeed
	self.impulse = true
	self.impulseWait = 0.0

func speedTarget() -> float:
	return self.speedFix

func rotationSet(_delta) -> void:
	self.rotation = 0#lerp_angle(self.rotation, (self.lastDirection).angle(), rotationSpeed * _delta)
