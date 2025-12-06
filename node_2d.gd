extends Node2D

@export var raio: float = 50.0
@export var cor: Color = Color(1.0, 0.0, 0.0) # Vermelho
@export var preenchido: bool = true

func _process(delta: float) -> void:
	queue_redraw()
	
func _draw():
	if preenchido:
		draw_circle(Vector2.ZERO, raio, cor) # Desenha círculo preenchido
	else:
		draw_circle(Vector2.ZERO, raio, cor) # Desenha contorno (pode precisar de draw_polygon com muitos pontos para borda fina)
