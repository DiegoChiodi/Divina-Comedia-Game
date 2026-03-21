extends GPUParticles2D
class_name ParticleBase

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_size_viewport()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	folliwing_cam()

func folliwing_cam() -> void:
	self.global_position = game_manager.camera.global_position

func set_size_viewport() -> void:
	var viewport_size := get_viewport().get_visible_rect().size
	self.process_material.emission_box_extents.x = viewport_size.x * 0.5
	self.process_material.emission_box_extents.y = viewport_size.y * 0.5
