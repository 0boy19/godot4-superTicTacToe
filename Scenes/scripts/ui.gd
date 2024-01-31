extends CanvasLayer
class_name ui
signal game_started
var game_points
var lletter #test for game_over #works
func restart():
	lletter = ""
	Game.reset_data_store()
	Game.reset_Loc_Boards_Score()
	Game.reset_global_winTie()
	Game.reset_active_Boards()
	Game.active_Boards = [0,1,2,3,4,5,6,7,8]
# Called when the node enters the scene tree for the first time.
func _ready():
	lletter = ""
	$background.hide()
	
	Game.connect("ui_turnLabelUpdate", self._on_ui_turn_label_update) #connect signal from signalton to this
	Game.connect("ui_game_over", self._on_ui_game_over) 
	$during_game.visible = true
	$game_over_screen.visible = false
	$during_game/PlayerTurn.text = str("[wave amp=14.0 freq=7.0 connected=1] X's turn [/wave]")
	#maybe remove this later
	var text
	if Game.move_count % 2 == 0:#if even, play x, if odd play o #WORKS IN REVERSE IDK
		text = "o"
	else:
		text = "x"
	$during_game/PlayerTurn.text = str("[wave amp=14.0 freq=7.0 connected=1] ",text,"'s turn [/wave]")


#recives signal from game.gd
func _on_ui_turn_label_update(playerLetter): #recives signal from game.gd
	#var turn = Game.isXTurn
	print("Game.isXTurn",Game.isXTurn)
	if playerLetter == "o":
		playerLetter = "X"
	else:#if "x"
		playerLetter = "O"
	$during_game/PlayerTurn.text = str("[wave amp=14.0 freq=7.0 connected=1] ",playerLetter,"'s turn [/wave]")

func _on_back_to_main_menu_pressed():
	restart()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
	


func _on_restart_button_pressed():
	$background.hide()
	$game_over_screen.visible=false
	$during_game.visible=true
	restart()
	_ready()
	get_tree().reload_current_scene()
	

func _on_ui_game_over(letter):
	$game_over_screen/wait_for_screen.start()
	lletter = letter
	
func _on_wait_for_screen_timeout():
	$game_over_screen.visible = true
	$during_game.visible = false
	$background.show()
	if lletter == "tie":
		$game_over_screen/WinnerDisplay.text = "It was a tie, GG."
	else:#if x/o
		$game_over_screen/WinnerDisplay.text = str("[rainbow freq=1.0 sat=1 val=0.8]Winner[/rainbow]  is ",lletter, "!")
