extends KinematicBody2D

export (int) var speed = 200;
var velocity = Vector2();

var facing = "down";
onready var sprite = $sprite;
var moving = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_left') && velocity.y == 0:
		velocity.x -= 1;
		facing = "left";
	if Input.is_action_pressed('ui_right') && velocity.y == 0:
		velocity.x += 1;
		facing = "right";
	if Input.is_action_pressed('ui_up') && velocity.x == 0:
		velocity.y -= 1;
		facing = "up";
	if Input.is_action_pressed('ui_down') && velocity.x == 0:
		velocity.y += 1;
		facing = "down";
	velocity = velocity.normalized() * speed;
	
func _physics_process(delta):
	get_input()
	if velocity.x == 0 && velocity.y == 0:
		moving = false;
	else:
		moving = true;
	updateFrames()
	velocity = move_and_slide(velocity);
	
func updateFrames():
	if facing == "down":
		sprite.play("down");
	elif facing == "up":
		sprite.play("up");
	elif facing == "right":
		sprite.play("right");
	elif facing == "left":
		sprite.play("left");
	
	if moving:
		sprite.playing = true;
	else:
		sprite.playing = false;
		sprite.frame = 0;