extends Node2D

var speed : float = 100;
func _process(delta):
	# speed += 2.5;
	self.position.x -= speed * delta;

func _on_CloudArea_body_entered(body):
	if body.name == "Dest":
		queue_free();