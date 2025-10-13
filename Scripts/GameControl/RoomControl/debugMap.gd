extends BaseScene
class_name DebugMap

@onready var shadow : ShadowEnemy = $Shadow
@onready var slow : ConfuseEnemy = $ConfuseEnemy
@onready var shield : ShieldEnemy = $ShieldEnemy
@onready var wasp : WaspEnemy = $WaspEnemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Enemys
	"""
	slow.setup(player)
	shadow.setup(player)
	shield.setup(player)
	"""
	wasp.setup(player)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
