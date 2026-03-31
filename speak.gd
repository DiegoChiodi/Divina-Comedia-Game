extends Node
class_name Speech

enum Speaker {
	DANTE,
	VIRGILIO,
	VOID
}

var speaker : Speaker
var text : String
var event : String

func _init(_speaker : Speaker, _text := "", _event := ""):
	self.speaker = _speaker
	self.text = _text
	self.event = _event
