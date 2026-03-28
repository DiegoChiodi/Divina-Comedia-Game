extends Node
class_name Level

var map : Map = null

func _ready() -> void:
	pass

func setup() -> void:
	self.map = get_node('map')

func out_bounds(body : Entity) -> void:
	map.out_bounds(body)
