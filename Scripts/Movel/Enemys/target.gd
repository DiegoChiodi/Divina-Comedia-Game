extends Entity
class_name Target

func _ready() -> void:
	super._ready()
	self.lifeMax = 100.0
	self.life = self.lifeMax
	
func speedTarget() -> float:
	return 0.0

func groupsAdd() -> void:
	self.add_to_group("Object")

func directionTarget() -> void:
	self.direction = Vector2.ZERO
