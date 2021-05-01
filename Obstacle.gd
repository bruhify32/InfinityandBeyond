extends Node2D

signal PlayerDeath;

onready var crash_sound = $Crash_sound;
var speed : float = 300;

func _process(delta):
	# speed += 2.5;
	self.position.x -= speed * delta;

func _on_Area2D_body_entered(body):
	if body.get_parent().name == "Destroyer":
		queue_free();
	if body.name == "Player":
		crash_sound.play();
		emit_signal("PlayerDeath");
		
