extends Node
class_name Speech

var speaker : global.Speaker
var text : String
var event : global.Event
var data : Array

func _init(_speaker : global.Speaker, _text := "", _event : global.Event = global.Event.VOID, _data := []):
	self.speaker = _speaker
	self.text = _text
	self.event = _event
	self.data = _data
