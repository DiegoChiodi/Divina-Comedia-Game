extends Camera2D
class_name Camera

#Nodes
var target
#Camera ----------------
var lissing = 10
var posTarget = Vector2.ZERO
var canBallFollow = false
var posComp : Vector2 = Vector2.ZERO
# Parâmetros do tremor
var shake_amount = 0.0
var shake_decay = 1.0  # Velocidade com que o tremor diminui
var original_offset := Vector2.ZERO
var zoomTarget := Vector2(3.5,3.5)
var zoomLissing := 0.98

var debugCamZoom = false
var permitionDebugZoom = false

var fixLissing = 0.3

func _ready():
	self.original_offset = offset  # Armazena a posição original da câmera
	self.limit_left = 0
	self.limit_top = 0

func _process(_delta):
	if self.target != null:
		self.posTarget = self.target.global_position + self.posComp
	
	self.position = self.position.lerp(self.posTarget, _delta * self.lissing)  # Ajuste o "5.0" para mudar a suavidade
	if self.shake_amount > 0:
		# Aplica uma posição aleatória
		self.offset = self.original_offset + Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * self.shake_amount
		
		# Reduz a intensidade ao longo do tempo
		self.shake_amount = max(self.shake_amount - self.shake_decay * _delta, 0)
	else:
		# Restaura a posição original
		self.offset = self.original_offset
	
	#self.zoom = lerp(self.zoom,self.zoomTarget,self.zoomLissing)


func setup(_target, _posComp) -> void:
	setTarget(_target, _posComp)

func setFixLissing(_fixLissing):
	self.fixLissing = self._fixLissing

func start_shake(intensity: float, decay: float = 1.0):
	self.shake_amount = intensity
	self.shake_decay = decay

func setLimit(_limit : Vector2i) -> void:
	self.limit_left = 0
	self.limit_top = 0
	self.limit_right = _limit.x
	self.limit_bottom = _limit.y

func setTarget(_target, _posComp) -> void:
	self.target = _target
	if _posComp != null:
		setPosComp(_posComp)
	
func setPosComp(_posComp) -> void:
	self.posComp = _posComp

func setZoom(_zoomTarget : Vector2) -> void:
	self.zoomTarget = _zoomTarget

func setPosition(_pos : Vector2) -> void:
	self.position = _pos
