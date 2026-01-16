extends Map
class_name MapMountain

@onready var par_wind : GPUParticles2D = $vfx/par_wind
@onready var par_snow : GPUParticles2D = $vfx/par_snow
@onready var control_wind : Marker2D = $vfx/control_wind
@onready var control_snow : Marker2D = $vfx/control_snow
# Called when the node enters the scene tree for the first time.
func _ready () -> void:
	super._ready()
	self.id = GameManager.MapID.MOUNTAIN

func _on_enter_vestibule_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		game_manager.change_room(GameManager.LevelID.VESTIBULE_00)

func _process(delta: float) -> void:
	var player : Player = game_manager.player
	if player != null:
		par_wind.emitting = player.position.y < self.control_wind.position.y
		par_snow.emitting = player.position.y < self.control_snow.position.y
