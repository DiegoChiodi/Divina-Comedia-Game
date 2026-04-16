extends DialogueBase
class_name DiaFoundVirgilio

var virgilio : Virgilio = preload("res://Scene/virgilio.tscn").instantiate()

func _ready() -> void:
	super._ready()

func set_speechs() -> void:
	self.speechs = [
	Speech.new(D, "A saída… estava tão perto…"),
	Speech.new(D, "Por que fui impedido?"),
	Speech.new(D, "Estou… preso aqui."),

	Speech.new(D, "Isso não faz sentido…"),
	Speech.new(D, "Nada faz sentido.", global.Event.SPAWN_ENTITY, [self.virgilio, game_manager.roomContainer.currentRoom.spawn_virg.global_position]),

	Speech.new(G, "Faz mais sentido do que você imagina.", global.Event.TRADE_MODULATE, [self.virgilio, Color(0,0,0, 1.0)]),
	
	Speech.new(D, "Quem está aí?", global.Event.MOVE_ENTITY, [game_manager.player, game_manager.roomContainer.currentRoom.spawn_virg.global_position + Vector2.LEFT * 530, 5.0, 1.4]),

	Speech.new(D, "Mostre-se!", global.Event.MOVE_ENTITY,[game_manager.player, game_manager.roomContainer.currentRoom.spawn_virg.global_position + Vector2.LEFT * 510, 5.0, 0.2]),
	
	Speech.new(G, "Alguém que conhece este caminho.", global.Event.CAM_ZOOM, [1.6]),
	Speech.new(G, "E o seu destino.", global.Event.TRADE_MODULATE, [self.virgilio, Color(1,1,1, 1.0)]),

	Speech.new(D, "Se conhece o caminho… me tire daqui."),

	Speech.new(G, "Não por onde você tentou."),
	Speech.new(G, "A subida está bloqueada para você."),

	Speech.new(D, "Então não há saída?"),

	Speech.new(G, "Há."),
	Speech.new(G, "Mas não acima."),

	Speech.new(G, "Você deve descer… antes de subir.", global.Event.MOVE_ENTITY, [self.virgilio, game_manager.roomContainer.currentRoom.spawn_virg.global_position + Vector2.LEFT * 8, 2.0, 0.2]),
	Speech.new(G, "Atravessar aquilo que teme."),

	Speech.new(D, "Descer… para onde?"),

	Speech.new(G, "Para onde todos evitam olhar."),

	Speech.new(D, "Por que eu?"),

	Speech.new(G, "Porque você foi chamado."),

	Speech.new(D, "Chamado… por quem?"),

	Speech.new(G, "Alguém que ainda acredita em você."),
	Speech.new(G, "Uma alma do alto viu sua queda."),
	Speech.new(G, "E recusou deixá-lo aqui."),
	Speech.new(G, "Ela pediu que eu viesse."),

	Speech.new(D, "Eu não sou forte o suficiente."),
	Speech.new(D, "Você viu o que me fez recuar."),

	Speech.new(G, "Você recuou… mas não fugiu."),
	Speech.new(G, "Isso já o diferencia."),

	Speech.new(G, "O medo não é o fim."),
	Speech.new(G, "É o começo."),

	Speech.new(D, "E se eu falhar?"),

	Speech.new(G, "Então falhará avançando."),
	Speech.new(G, "Não parado."),

	Speech.new(G, "Mas você não está sozinho."),

	Speech.new(G, "Venha."),
	Speech.new(G, "O caminho começa… aqui."),

	Speech.new(D, "…Certo."),
	Speech.new(D, "Eu vou."),
	Speech.new(V, "", global.Event.TRADE_PAUSE),
	Speech.new(V, "", global.Event.END)
	]

func event_control(_delta : float) -> void:
	if self.current_speench >= self.speechs.size():
		return
	var data : Array = speechs[current_speench].data
	match speechs[current_speench].event:
		global.Event.MOVE_ENTITY:
			if data.size() > 3:
				self.per_pass_spreench = self.move_ani_entity_to_point(data[0], data[1], data[2], data[3])
			else:
				self.per_pass_spreench = self.move_ani_entity_to_point(data[0], data[1], data[2])
			if self.per_pass_spreench:
				self.pass_text()
			
		global.Event.SPAWN_ENTITY:
			self.spawn_entity(data[0], data[1])
			self.pass_text()
		global.Event.CAM_ZOOM:
			self.per_pass_spreench = self.camera_zoom(data[0])
			if self.per_pass_spreench:
				self.pass_text()
		global.Event.VOID:
			pass
		global.Event.TRADE_PAUSE:
			self.trade_pause()
			self.camera_zoom(1.0)
		global.Event.END:
			self.end()
		global.Event.TRADE_MODULATE:
			self.per_pass_spreench = self.trade_modulate(data[0], data[1], _delta)
			if self.per_pass_spreench:
				self.pass_text()
			

func move_ani_entity_to_point(entity : AnimationEntity, point : Vector2, stop_marge : float = 2.0, extra_speed : float = 1.0) -> bool:
	if abs(entity.global_position.distance_to(point)) > stop_marge:
		entity.direction = entity.global_position.direction_to(point) * extra_speed
		
		return false
	entity.direction = Vector2.ZERO 
	return true

func camera_zoom(zoom : float) -> bool:
	if abs(game_manager.camera.zoomTarget.length() - (Vector2.ONE * zoom).length()) >= 0.1:
		game_manager.camera.zoomTarget = Vector2.ONE * zoom
		game_manager.camera.posComp = Vector2(300.0, 150.0)
	return true

func spawn_entity(entity, pos : Vector2) -> void:
	game_manager.roomContainer.currentRoom.add_child(entity)#Problem, instanciando mesmo objeto mais de uma vez
	#tendo varios parentes
	entity.global_position = pos

func trade_modulate(entity : Node2D, color : Color, _delta : float) -> bool:
	if global.color_distance(entity.modulate, color) > 0.05:
		entity.modulate = entity.modulate.lerp(color, 0.98 * _delta)
		return false
	entity.modulate = color
	return true
		
