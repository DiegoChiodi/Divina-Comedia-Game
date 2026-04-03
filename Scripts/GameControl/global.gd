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

func color_distance(c1: Color, c2: Color) -> float:
	var dr = c1.r - c2.r
	var dg = c1.g - c2.g
	var db = c1.b - c2.b
	return dr*dr + dg*dg + db*db
