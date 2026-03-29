extends Node
class_name Speak

enum Speakers {
	DANTE,
	VIRGILIO
}

var speaker : Speakers
var text : String
var event : String

func _init(_speaker : Speakers, _text := "", _event := ""):
	speaker = _speaker
	text = _text
	event = _event
