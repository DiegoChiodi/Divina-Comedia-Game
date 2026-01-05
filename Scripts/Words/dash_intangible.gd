extends StaticBody2D

@onready var col : CollisionShape2D = self.get_node('CollisionShape2D')
@onready var area : Area2D = $Area2D
@onready var col_area : CollisionShape2D = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if game_manager.player != null:
		self.col.disabled = game_manager.player.inDash
		var bodies := area.get_overlapping_bodies()
		for body in bodies:
			if body is Player:
				body.dashDuringWait = 0.15
				body.invencibilityActivate(false, 0.1)
	
