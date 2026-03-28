extends Node
class_name Dialogue_base

var texts : Array[String] = ["Testando, se der certo eu sou muito bom"]
var current_text : int = 0
var text_vis : String
var current_char : int = 0

@onready var label : Label = $Label

const DELAY_ADD : float = 0.05
var wait_add : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if self.wait_add > self.DELAY_ADD and texts[current_text].length() > self.current_char:
		self.wait_add = 0.0
		self.text_vis = self.text_vis + self.texts[self.current_text][self.current_char]
		self.current_char += 1
	else:
		self.wait_add += _delta
	self.label.text = self.text_vis
