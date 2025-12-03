extends CharacterBody2D
class_name Movel

var direction : Vector2 = Vector2.ZERO
var impulseDir : Vector2 = Vector2.ZERO
var impulseSpeed : float = 1500.0
var lastDirection : Vector2 = Vector2.RIGHT

var speedFix : float = 250.0
var speed : float = self.speedFix # Velocidade constante que guia movimento
var workaroundSpeed : float = 200.0
var acceleration : float = 0.4  # Fator de suavização
var rotationSpeed : float = 15

var impulseDelay : float =  1.0
var impulseWait : float = impulseDelay
var impulse : bool = false

var weight : float  = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	directionTarget()
	self.impulseDir = self.impulseDir.lerp(Vector2.ZERO, self.acceleration)
	self.rotationSet(delta)
	
	if self.direction != Vector2.ZERO:
		self.lastDirection = direction
	
	if self.impulseWait >= self.impulseDelay:
		self.impulse = false
	else:
		self.impulseWait += delta

func _physics_process(_delta: float) -> void:
	self.move(_delta)

func move(_delta: float) -> void:
	var target_velocity = self.velocityTarget()

	# 1. Aceleração normal (input)
	if target_velocity != Vector2.ZERO:
		self.velocity = self.velocity.lerp(target_velocity, self.acceleration)
	else:
		# Sem input → desaceleração
		self.velocity = velocity.lerp(Vector2.ZERO, self.acceleration)
	
	# 2. Movimento real
	var collision = move_and_collide(self.velocity * _delta)

	# 3. Física do ricochete
	if collision:
		self.velocity = self.velocity.bounce(collision.get_normal())

func velocityTarget() -> Vector2:
	return self.velocity.lerp((self.direction * speedTarget()) + (self.impulseSpeed * self.impulseDir * (1 / self.weight)), self.acceleration)

func directionTarget() -> void:
	pass

func takeImpulseDir(_impulseDir : Vector2, _impulseSpeed : float = 500) -> void:
	self.impulseDir = _impulseDir
	self.impulseSpeed = _impulseSpeed
	self.impulse = true
	self.impulseWait = 0.0

func speedTarget() -> float:
	return self.speedFix

func rotationSet(_delta) -> void:
	self.rotation = 0#lerp_angle(self.rotation, (self.lastDirection).angle(), rotationSpeed * _delta)
