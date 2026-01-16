extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size := get_viewport().get_visible_rect().size
	process_material.emission_box_extents.x = viewport_size.x * 0.5
	process_material.emission_box_extents.y = viewport_size.y * 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = game_manager.camera.position
