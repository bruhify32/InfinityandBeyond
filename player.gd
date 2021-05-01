extends KinematicBody2D

export var JUMP_FORCE : int = 500;
export var Gravity : int = 25;
var motion : Vector2 = Vector2();
export var game_over : bool = true;
onready var jump_sound = $Jump_sound;


func _physics_process(delta):
	_gravity();
	motion = move_and_slide(motion,Vector2(0,-1));
	if game_over:
		$AnimatedSprite.play("idle");
	else:
		$AnimatedSprite.play('run');


func _input(event):
	if event:
		if Input.is_action_just_pressed("Jump") and !game_over:
			_jump();
			

func _gravity():
	if not is_on_floor():
		motion.y += Gravity ;

func _jump():
	if is_on_floor() and !game_over:
		motion.y -= JUMP_FORCE;
		jump_sound.play();
		
