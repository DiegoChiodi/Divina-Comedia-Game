extends Node
class_name Speech

enum Speaker {
	DANTE,
	VIRGILIO,
	VOID
}

enum Event {
	MOVE_ENTITY,
	SPAWN_ENTITY,
	VOID,
	CAM_ZOOM
}

var speaker : Speaker
var text : String
var event : Event
var data : Array

func _init(_speaker : Speaker, _text := "", _event : Event = Event.VOID, _data := []):
	self.speaker = _speaker
	self.text = _text
	self.event = _event
	self.data = _data
