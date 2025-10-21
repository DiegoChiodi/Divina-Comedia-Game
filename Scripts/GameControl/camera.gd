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
	original_offset = offset  # Armazena a posição original da câmera
	self.limit_left = 0
	self.limit_top = 0

func _process(delta):
	if target != null:
		posTarget = target.global_position + posComp
	
	self.position = self.position.lerp(posTarget, delta * lissing)  # Ajuste o "5.0" para mudar a suavidade
	if shake_amount > 0:
		# Aplica uma posição aleatória
		offset = original_offset + Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * shake_amount
		
		# Reduz a intensidade ao longo do tempo
		shake_amount = max(shake_amount - shake_decay * delta, 0)
	else:
		# Restaura a posição original
		offset = original_offset
	
	#self.zoom = lerp(self.zoom,self.zoomTarget,self.zoomLissing)

func setup(_target, _posComp) -> void:
	setTarget(_target, _posComp)

func setFixLissing(_fixLissing):
	fixLissing = _fixLissing

func start_shake(intensity: float, decay: float = 1.0):
	shake_amount = intensity
	shake_decay = decay

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
	posComp = _posComp

func setZoom(_zoomTarget : Vector2):
	zoomTarget = _zoomTarget
