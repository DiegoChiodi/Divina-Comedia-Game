extends StaticBody2D

var direction : Vector2 = Vector2.ZERO
var move_direction : Vector2 = Vector2.ZERO


var dashDuringDelay : float = 0.2
var dashDuringWait : float = self.dashDuringDelay

var dashDelay : float = 1.0
var dashWait : float = self.dashDelay
var dashPoss : bool = false # se é possivel dar dash

var speed : float = 0.0 # Velocidade que vai influenciar o movimento
var speedTarget : float = 0.0 #vai ser quem a speed deve chegar, propósito: efeito de aceleração
var speedFix : float = 250.0 # velocidade max que speed pode chegar normalmente
var acceleration : float = 0.2  # Fator de suavização
var inDash : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	self.direction = Input.get_vector("left", "right", "up", "down")
	var space : bool = Input.is_action_just_pressed("space")
	
	if direction != Vector2.ZERO:
		self.speed = lerp(self.speed, self.speedFix, acceleration)
	else:
		self.speed = lerp(self.speed, 0.0, acceleration)
	
	if space && dashPoss:
		#Dando dash
		self.inDash = true
		self.dashDuringWait = 0.0
		#cowdow do dash para usar denovo
		self.dashPoss = false
		self.dashWait = 0.0

	if self.dashDuringWait < self.dashDuringDelay:
		self.dashDuringWait += delta
	else:
		self.inDash = false
	
	if self.dashWait < self.dashDelay:
		self.dashWait += delta
		$ColorRect.modulate = Color(1,1,0)
	else:
		self.dashPoss = true
		$ColorRect.modulate = Color(0,1,0)
	
	if self.inDash:
		self.speed = self.speedFix * 3
		$ColorRect.modulate = Color(1,0,0)
	else:
		self.move_direction = self.direction
	
	self.position += self.move_direction * self.speed * delta
