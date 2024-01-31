extends ParallaxBackground

@export var speed := 10.0

@export var direction = Vector2.LEFT
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	scroll_base_offset += (speed * direction) * delta
