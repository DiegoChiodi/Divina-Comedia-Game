extends Node
class_name Level

var map : Map = null

func setup() -> void:
	self.map = get_node('map')

func out_bounds() -> void:
	map.out_bounds()
