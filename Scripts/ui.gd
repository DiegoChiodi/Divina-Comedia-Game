extends CanvasLayer
class_name UI

@onready var clr_shadow : ColorRect = $clr_shadow
@onready var mar_dial : Marker2D = $mar_dial
var actual_dial : DialogueBase


func _ready() -> void:
	pass


func start_dialogue(_dialogue : DialogueBase) -> void:
	self.add_child(_dialogue)
	self.actual_dial = _dialogue
	self.actual_dial.position = self.mar_dial.position
	self.actual_dial.connect("finished", self._on_dialogue_finished)

func _on_dialogue_finished():
	self.actual_dial = null
