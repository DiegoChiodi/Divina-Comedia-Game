extends Node
class_name Global

var roomLimit : Vector2

var enter_top_mountain : bool = false

var pause_dialogue : bool = false 

enum Speaker {
	DANTE,
	VIRGILIO,
	VOID
}

enum Event {
	MOVE_ENTITY,
	SPAWN_ENTITY,
	VOID,
	CAM_ZOOM,
	TRADE_PAUSE,
	END,
	TRADE_MODULATE
}
