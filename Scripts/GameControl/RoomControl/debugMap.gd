extends BaseScene
class_name DebugMap

@onready var shadow : ShadowEnemy = $Shadow
@onready var slow : ConfuseEnemy = $ConfuseEnemy
@onready var shield : ShieldEnemy = $ShieldEnemy
@onready var wasp : WaspEnemy = $WaspEnemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Enemys
	
	if false:
		slow.speedFix = 0.0
		shadow.speedFix = 0.0
		shield.speedFix = 0.0
		wasp.speedFix = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
