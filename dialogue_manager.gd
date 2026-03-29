extends Node
class_name Dialogue_base

var speaks : Array[Speak] = []
var current_text : int = 0
var text_vis : String
var current_char : int = 0

@onready var label : Label = $Label

const DELAY_ADD : float = 0.02
var wait_add : float = 0.0

func _ready() -> void:
	set_speaks()

func _process(_delta: float) -> void:
	if self.wait_add > self.DELAY_ADD and !self.speaks.is_empty() and self.speaks[current_text].length() > self.current_char:
		self.wait_add = 0.0
		self.text_vis = self.text_vis + self.speaks[self.current_text].text[self.current_char]
		self.current_char += 1
	else:
		self.wait_add += _delta
	self.label.text = self.text_vis
	self.label.position = -self.label.size / 2 

func pass_text() -> void:
	self.current_text += 1
	self.current_char = 0
	self.text_vis = ""

func set_speaks() -> void:
	pass
