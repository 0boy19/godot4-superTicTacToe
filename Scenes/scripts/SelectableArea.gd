extends Area2D
@onready var x = preload("res://Scenes/cross.tscn")
@onready var o = preload("res://Scenes/circle.tscn")

var selected = false #this is to know if mouse is hovering over/selecting the pos.

@export var pos = -1 #I can change this in the editor, -1 is a placeholder. It is changed during runtime to what was assigned in the editor
					#It's to know which local pos is which, used in check_win.


func _ready():
	$mouse_over.hide() #mouse_over shows what selection your mouse is hovering over.

func _on_mouse_entered():
	#if(!selected and !Game.win):  #if it's not selected and the Games not been won, continue
	if(!selected and !Game.globalWin):
		$mouse_over.show()

func _on_mouse_exited():
	$mouse_over.hide()
	
	

	

func play_x(boardNum:int,boardPos:int): #boardNum works, what we need to do is add this to a dictionary just for the  local board.
	if (!selected and !Game.globalWin):
		add_child(x.instantiate()) #this instances the "cross" scene to be placed on the board.
		#print("DATA STORE",Game.data_store)
		print("BOARD NO. ", boardNum) #prints which board
		print("BOARD POS. ", boardPos) #prints board pos
		localBoardDictionaryadd(boardNum,boardPos, "x") #adds pos to corresponding local board.
		Game.check_win(boardPos,"x",boardNum)
		
		
	
func play_o(boardNum:int,boardPos:int):
	if (!selected and !Game.globalWin):
		add_child(o.instantiate())
		print("BOARD NO. ", boardNum) #prints which board
		print("BOARD POS. ", boardPos) #prints pos on said board
		localBoardDictionaryadd(boardNum,boardPos, "o") #adds pos to corresponding local board.
		Game.check_win(boardPos,"o",boardNum)
		
		



func _on_input_event(_viewport, event, _shape_idx): #when we click a pos
	if event.is_action_pressed("primary action") and selected == false:
		var boardNum = $".".get_owner().global_pos #the local board number pos is in, thsese have to happen during runtime
		var boardPos = $".".pos
		Game.move_count
		print("Game.move_count",Game.move_count)
		Game.move_count = Game.move_count + 1
		print("them moves1: ", Game.move_count)
		print("them moves3: ", Game.move_count % 2)

		if Game.move_count % 2 == 0:#if even, play x, if odd, playo
			print("them moves2: ", Game.move_count)
			play_x(boardNum,boardPos)
		else:
			play_o(boardNum,boardPos)
			
		$mouse_over.hide()
		selected = true

	#elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and selected == false:
		#play_o(boardNum,boardPos)
		#$mouse_over.hide()
		#selected = true

		
		
##TODO:
## In this script, check which board does pos belong to, from there we can add values to each global pos.
## -Maybe it's a func
##
##


func localBoardDictionaryadd(boardNum:int, boardPos:int, letter :String): #this adds the values to their corrosponding dictionaries.
	var boards = [Game.board0, Game.board1, Game.board2, Game.board3, Game.board4, Game.board5, Game.board6, Game.board7, Game.board8]
	
	if boardNum >= 0 and boardNum < boards.size():
		boards[boardNum][boardPos] = letter
		print("I am board ", boardNum, ":", boards[boardNum])
		
	else: #TODO: IDEA if boardNum is -1, it is the global board!!!
		pass




