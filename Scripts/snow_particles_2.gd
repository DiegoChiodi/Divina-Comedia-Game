extends ParticleBase
class_name snow_particle

func set_size_viewport() -> void:
	var viewport_size := get_viewport().get_visible_rect().size
	process_material.emission_box_extents.x = viewport_size.x
	process_material.emission_box_extents.y = viewport_size.y * 0.2

func folliwing_cam() -> void:
	self.position = game_manager.camera.position - Vector2(0,get_viewport().get_visible_rect().size.y / 2)
