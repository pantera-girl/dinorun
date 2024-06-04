extends Node2D
@export var mob_scene: PackedScene
var screen_size : Vector2i
var PlayerInitialPosition

func _ready():
	screen_size = get_window().size
	PlayerInitialPosition = $player.position
	GHUD.start_game.connect(new_game)

func game_over():
	GHUD.update_highscore_label()
	$MOBTimer.stop()
	

func new_game():
	$Floor.position.x = 0
	$player.position = PlayerInitialPosition
	$MOBTimer.start()
	GHUD.mob_counter = 0
func _process(delta):
	$Floor.position.x = $player.position.x -150
	


func _on_mob_timer_timeout():
	print(GHUD.mob_counter,"mobs")
	if GHUD.mob_counter < 2:
		var mob = mob_scene.instantiate()
		mob.position.x = $player.position.x + 1500
		mob.position.y = 640
		add_child(mob)
		mob.hit.connect(game_over)
