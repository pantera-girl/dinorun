extends CharacterBody2D

const SPEED = 500
const JUMP_VELOCITY = -1000
var speed_scale = 1
const gravity = 2600

func _physics_process(delta):
	if GHUD.is_playing == true: 
		if GHUD.score > 150:
			speed_scale = GHUD.score/150
		if is_on_floor():
			if Input.is_action_pressed("ui_down"):
				$CollisionShape2D.disabled = true
				$AnimatedSprite2D.play("crouch")
			else:
				$CollisionShape2D.disabled = false
				$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("jump")
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			$Audiojump.play()
			velocity.y = JUMP_VELOCITY
		velocity.x = SPEED + GHUD.score
		velocity.y += gravity * delta 
		$CrouchCollisionShape2D2.disabled = !$CollisionShape2D.disabled
		move_and_slide()
