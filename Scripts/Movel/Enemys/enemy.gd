extends Entity
class_name Enemy

var colDetectPlayer : Area2D 
var seeingPlayer : bool = false
var timerLengthen := Timer.new() 
var timerLengthenDuration := Timer.new()
var inLengthen : bool = false

func _ready() -> void:
	super._ready()
	add_child(self.timerLengthen)
	add_child(self.timerLengthenDuration)
	
	self.timerLengthen.timeout.connect(self.resetTimer)
	self.timerLengthenDuration.timeout.connect(self.lengthenEnd)
	self.timerLengthen.wait_time = 8
	self.timerLengthen.start()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func checkCollidingRival(body) -> bool:
	if (body == game_manager.player):
		return true
	return false

func directionTarget() -> void:
	if game_manager.player != null and self.seeingPlayer:
		self.direction = setDirection()
	else:
		if self.inLengthen:
			return
		self.direction = self.direction.lerp(Vector2.ZERO,0.1)

func setDirection() -> Vector2:
	return (game_manager.player.position - self.position).normalized()

func groupsAdd() -> void:
	self.add_to_group("Enemy")
	self.groupRival = "Player"

func resetTimer() -> void:
	if !self.seeingPlayer:
		self.lengthen()
		self.timerLengthen.wait_time = randi_range(5,12)
		self.timerLengthen.start()

func _on_are_check_player_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !self.seeingPlayer:
		self.detectPlayer()

func lengthen() -> void:
	self.direction = Vector2(randf_range(-1,1),randf_range(-1,1))
	self.timerLengthenDuration.wait_time = randf_range(0.2,0.4)
	self.inLengthen = true
	self.timerLengthenDuration.start()

func lengthenEnd() -> void:
	self.inLengthen = false

func detectPlayer() -> void:
	self.seeingPlayer = true
