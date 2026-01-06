extends CharacterBody2D
class_name Movel

var direction : Vector2 = Vector2.ZERO
var impulseDir : Vector2 = Vector2.ZERO
var impulseSpeed : float = 1500.0
var lastDirection : Vector2 = Vector2.RIGHT

var speedFix : float = 250.0
var speed : float = self.speedFix # Velocidade constante que guia movimento
var workaroundSpeed : float = 200.0
var acceleration : float = 15.0  # Fator de suavização
var rotationSpeed : float = 15

var impulseDelay : float =  1.0
var impulseWait : float = self.impulseDelay
var impulsionable : bool = true

const MINEXTERNALFORCE : float = 300.0
var external_velocity : Vector2 = Vector2.ZERO
const PUSHDELAY : float = 0.05
var pushWait : float = 0.0

var weight : float  = 1.0

var ricochet : bool = false

func _process(delta: float) -> void:
	directionTarget()
	self.rotationSet(delta)

	if self.direction != Vector2.ZERO:
		self.lastDirection = self.direction

	if self.impulseWait <= self.impulseDelay:
			self.impulseWait += delta

func _physics_process(_delta: float) -> void:
	self.move(_delta)
	self.pushWait += _delta

func move(_delta: float) -> void:
	var target_velocity = self.velocityTarget(_delta)
	
	self.external_velocity = self.external_velocity.lerp(Vector2.ZERO, self.acceleration * _delta)
	self.impulseDir = self.impulseDir.lerp(Vector2.ZERO, self.acceleration * _delta)
	
	if self.pushWait > self.PUSHDELAY:
		self.pushWait -= _delta
	
	# 1. Aceleração normal (input)
	if target_velocity != Vector2.ZERO:
		self.velocity = self.velocity.lerp(target_velocity, self.acceleration * _delta)
	else:
		# Sem input → desaceleração
		self.velocity = velocity.lerp(Vector2.ZERO, self.acceleration * _delta)
	# 2. Movimento real
	
	move_method(_delta)
	
	self.farlands_limit()

func velocityTarget(_delta : float) -> Vector2:
	return ((self.direction * speedTarget()) + (self.impulseSpeed * self.impulseDir * (1 / self.weight)) + self.external_velocity)

func directionTarget() -> void:
	pass

func takeImpulse(_impulseDir : Vector2, _impulseSpeed : float = 1200) -> void:
	if self.impulsionable:
		self.impulseDir = _impulseDir
		self.impulseSpeed = _impulseSpeed
		self.impulseWait = 0.0

func speedTarget() -> float:
	return self.speedFix

func rotationSet(_delta) -> void:
	self.rotation = 0 #lerp_angle(self.rotation, (self.lastDirection).angle(), rotationSpeed * _delta)

func add_central_force(_force: Vector2):
	if self.pushWait >= self.PUSHDELAY:
		self.external_velocity += _force
		self.pushWait = 0.0

func farlands_limit() -> void:
	self.position = self.position.clamp(Vector2.ZERO, global.roomLimit)

func ricochetied(collision : KinematicCollision2D) -> void:
	self.velocity = self.velocity.bounce(collision.get_normal())

func move_method(_delta : float) -> void:
	move_and_slide()
