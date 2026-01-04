extends Entity
class_name AnimationEntity

var sprite : AnimatedSprite2D
var lastDirectionX : float = 0.0

func _ready() -> void:
	super._ready()
	set_sprite()
	
func _process(delta: float) -> void:
	super._process(delta)
	drawSelfDir()

func set_sprite() -> void:
	self.sprite = $sprite
	self.sprite.play()
	
func drawSelfDir() -> void:
	if abs(self.direction.length()) <= 0.2:
		idle()
	else:
		run()

func run() -> void:
	if abs(self.direction.x) >= abs(self.direction.y):
		self.run_x()
		self.sprite.flip_h = false if self.lastDirection.x > 0 else true
		return
	else:
		if direction.y < 0:
			self.run_up()  # Animação para cima
		else: 
			self.run_down()
	
	self.sprite.flip_h = false

func idle() -> void:
	if abs(self.lastDirection.x) >= abs(self.lastDirection.y):
		self.idle_x()
	else:
		if lastDirection.y < 0:
			self.idle_up()  # Animação para cima
		else: 
			self.idle_down()

func run_x() -> void:
	self.sprite.play('run_x')

func run_up() -> void:
	self.sprite.play('run_up')

func run_down() -> void:
	self.sprite.play('run_down')

func idle_x() -> void:
	self.sprite.play('idle_x')

func idle_up() -> void:
	self.sprite.play('idle_up')

func idle_down() -> void:
	self.sprite.play('idle_down')
