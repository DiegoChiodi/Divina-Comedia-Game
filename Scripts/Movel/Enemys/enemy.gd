extends Entity
class_name Enemy

var seeingPlayer : bool = false
var player_near : bool = false
var timerLengthen := Timer.new() 
var timerLengthenDuration := Timer.new()
var inLengthen : bool = false

var nav_agent : NavigationAgent2D
var are_check_player : Area2D
var col_check_player : CollisionShape2D

func _ready() -> void:
	super._ready()
	self.get_are_check_player()
	
	add_child(self.timerLengthen)
	add_child(self.timerLengthenDuration)
	
	self.timerLengthen.timeout.connect(self.resetTimer)
	self.timerLengthenDuration.timeout.connect(self.lengthenEnd)
	self.timerLengthen.wait_time = 8.0
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
	if area.get_parent() is Player:
		self.player_near = true
		if !self.seeingPlayer:
			self.detectPlayer()

func _on_are_check_player_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		self.player_near = false

func lengthen() -> void:
	self.direction = Vector2(randf_range(-1,1),randf_range(-1,1))
	self.timerLengthenDuration.wait_time = randf_range(0.2,0.4)
	self.inLengthen = true
	self.timerLengthenDuration.start()

func lengthenEnd() -> void:
	self.inLengthen = false

func detectPlayer() -> void:
	if self.seeingPlayer:
		return

	self.seeingPlayer = true
	
	var areas := self.are_check_player.get_overlapping_areas()

	for area in areas:
		var parent : = area.get_parent() as Enemy
		if parent != null and parent != self:
			parent.detectPlayer()

func get_are_check_player() -> void:
	self.are_check_player = $are_checkPlayer
	self.col_check_player = $are_checkPlayer/col_checkPlayer

func colliding_projectile(projectile : Projectile) -> void:
	if ricochet:
		super.colliding_projectile(projectile)
