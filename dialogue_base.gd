extends Node2D
class_name DialogueBase

var speechs : Array[Speech] = []
var current_speench : int = 0
var text_vis : String
var current_char : int = 0
var start : bool = false
var finish_line : bool = false
var label : Label = Label.new()

var per_pass_spreench : bool = true

const V = Speech.Speaker.VOID
const D = Speech.Speaker.DANTE
const G = Speech.Speaker.VIRGILIO

const DELAY_ADD : float = 0.02
var wait_add : float = 0.0

func _ready() -> void:
	self.set_speechs()
	self.add_child(self.label)

func _process(_delta: float) -> void:
	if self.start:
		self.print_text(_delta)
		self.event_control(_delta)

func pass_text() -> void:
	self.current_speench += 1
	self.current_char = 0
	self.text_vis = ""
	self.label.reset_size()
	
func set_speechs() -> void:
	pass

func print_text(_delta : float) -> void:
	if self.current_speench >= self.speechs.size():
		return
	self.finish_line = self.speechs[self.current_speench].text.length() <= self.current_char
	if self.finish_line and Input.is_action_just_pressed('space') and self.per_pass_spreench:
		self.pass_text()
	
	if self.wait_add > self.DELAY_ADD and !self.speechs.is_empty() and !self.finish_line:
		self.wait_add = 0.0
		self.text_vis = self.text_vis + self.speechs[self.current_speench].text[self.current_char]
		self.current_char += 1
	else:
		self.wait_add += _delta
	
	self.label.text = self.text_vis
	if self.current_speench < self.speechs.size():
		var speeaker_pos_comp = Vector2.RIGHT * 200.0 * (-1 if self.speechs[self.current_speench].speaker == D else 1)
		var color := Color(1, 0.95, 0.8) if self.speechs[self.current_speench].speaker == D else Color(0.6, 0.7, 1.0)
		
		self.label.position = -self.label.size / 2 + speeaker_pos_comp
		self.label.modulate = color

func event_control(_delta : float) -> void:
	pass

func move_ani_entity_to_point(entity : AnimationEntity, point : Vector2) -> bool:
	print(self, "Não era pra tar printando isso, metodo abstrato")
	return false

func spawn_entity(entity, pos : Vector2) -> void:
	pass
