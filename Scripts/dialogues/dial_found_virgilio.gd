extends DialogueBase
class_name DiaFoundVirgilio

func _ready() -> void:
	super._ready()
func set_speechs() -> void:
	self.speechs = [
	Speech.new(D, "A saída… estava tão perto…"),
	Speech.new(D, "Por que fui impedido?"),
	Speech.new(D, "Estou… preso aqui."),

	Speech.new(D, "Isso não faz sentido…"),
	Speech.new(D, "Nada faz sentido."),

	Speech.new(V, "", "spawn_virgilio"),

	Speech.new(G, "Faz mais sentido do que você imagina."),

	Speech.new(D, "Quem está aí?"),
	Speech.new(D, "Mostre-se!"),

	Speech.new(G, "Alguém que conhece este caminho."),
	Speech.new(G, "E o seu destino."),

	Speech.new(D, "Se conhece o caminho… me tire daqui."),

	Speech.new(G, "Não por onde você tentou."),
	Speech.new(G, "A subida está bloqueada para você."),

	Speech.new(D, "Então não há saída?"),

	Speech.new(G, "Há."),
	Speech.new(G, "Mas não acima."),

	Speech.new(G, "Você deve descer… antes de subir."),
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

	Speech.new(G, "Venha.", "start_follow"),
	Speech.new(G, "O caminho começa… aqui."),

	Speech.new(D, "…Certo."),
	Speech.new(D, "Eu vou.")
	]
