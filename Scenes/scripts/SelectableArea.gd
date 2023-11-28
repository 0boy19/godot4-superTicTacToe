extends Area2D
@onready var x = preload("res://Scenes/cross.tscn")
@onready var o = preload("res://Scenes/circle.tscn")

var selected = false #this is to know if mouse is selecting smth.
@export var pos = -1 #I can change this in the editor, -1 is a placeholder. 
					#It's to know which local pos is which, used in check_win.
var local_boards = {}


func _ready():
	$mouse_over.hide() #mouse_over shows what selection your mouse is hovering over.

func _on_mouse_entered():
	if(!selected and !Game.win):  #if it's not selected and the Games not been won, con
		$mouse_over.show()

func _on_mouse_exited():
	$mouse_over.hide()
	
	
func localBoardDictionaryadd(boardNum, pos):
	local_boards[boardNum] = pos # has {BoardNum:PosNum]
	print(local_boards)
	
	

func play_x(boardNum): #boardNum works, what we need to do is add this to a dictionary just for the  local board.
	if (!selected and !Game.win):
		add_child(x.instantiate()) #this instances the "cross" scene to be placed on the board.
		Game.data_store[pos] = "x"
		Game.check_win(pos,"x")
		print(Game.data_store)
		print(boardNum, "this is me")
		localBoardDictionaryadd(boardNum, pos)
		
		
	
func play_o():
	if (!selected and !Game.win):
		add_child(o.instantiate())
		Game.data_store[pos] = "o"
		Game.check_win(pos,"o")
		


	

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("primary action") and selected == false:
		var boardNum = $".".get_owner().global_pos #the local board number pos is in, 
		play_x(boardNum)
		$mouse_over.hide()
		selected = true
		print($".".get_owner().global_pos) #prints which board
		print($".".get_name()) #prints board pos
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and selected == false:
		play_o()
		$mouse_over.hide()
		selected = true
		print($".".get_owner().get_name()) #prints which board
		print($".".get_name()) #prints board pos
		
##TODO:
## In this script, check which board does pos belong to, from there we can add values to each global pos.
## -Maybe it's a func
##
##






