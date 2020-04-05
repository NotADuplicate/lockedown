extends KinematicBody2D

export var speed = 800;
var direction = 0;
var screen_size #this feels like it belongs somewhere else
onready var fog = get_node("Camera2D/Fog")
onready var sprite = get_node("AnimatedSprite")

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	z_index = 99+position[1]*0.1
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("left"):
		velocity += Vector2.LEFT
	if Input.is_action_pressed("down"):
		velocity += Vector2.DOWN
	if Input.is_action_pressed("up"):
		velocity += Vector2.UP
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		direction = fposmod(floor(rad2deg(-velocity.angle())/45),8);
		if(0 < velocity.angle() && velocity.angle() <= PI): # ||velocity.y>0 || (velocity.y==0 && velocity.x<0)):
			direction += 1
		#print(direction);
		sprite.animation = "walk"+str(direction)
	else:
		sprite.animation = "idle"+str(direction)
	if(!test_move(transform,velocity * delta)):
		position += velocity * delta

func _on_Bullet_hit(damage):
	print("Hit for:")
	print(damage)
