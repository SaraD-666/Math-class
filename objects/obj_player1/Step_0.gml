
//inputs
var key_right = keyboard_check(vk_right);
var key_left = keyboard_check(vk_left);
var key_down = keyboard_check(vk_down);
var key_up = keyboard_check(vk_up);

switch(playerstate){
	case PlayerState.Idle:
	break;
	
	case PlayerState.Normal:
		//animation
		if (player_x != 0 || player_y != 0){
			if (key_right){
				current_sprite = spr_player1_rt;
				has_created = false;
			}
			if (key_up){
				current_sprite = spr_player1_up;
				has_created = false;
			}
			if (key_down){
				current_sprite = spr_player1_dw;
				has_created = false;
			}
			if (key_left){
				current_sprite = spr_player1_lt;
				has_created = false;
			}
		}
		sprite_index = current_sprite;

		//if obj_vison is not created create it
		if(!has_created){
			instance_destroy(obj_vision);
			//if current_sprite is up
			if (current_sprite == spr_player1_up){
				instance_create_layer(x, y-16,"Instances", obj_vision);
				has_created = true;
			}
			if (current_sprite == spr_player1_dw){
				instance_create_layer(x, y+16,"Instances", obj_vision);
				has_created = true;
			}
			if (current_sprite == spr_player1_rt){
				instance_create_layer(x+16, y,"Instances", obj_vision);
				has_created = true;
			}
			if (current_sprite == spr_player1_lt){
				instance_create_layer(x-16, y,"Instances", obj_vision);
				has_created = true;
			}
		}
		
		// Check for collision with any child of obj_collide_parent
		var colliding_instance = instance_place(obj_vision.x, obj_vision.y, obj_grab);

		// Check if the collision instance exists and is a child of obj_collide_parent
		if (colliding_instance != noone) {
			// Set pre_select in obj_player1 to the ID of the colliding instance
			pre_select = colliding_instance;
			
			//grab
			if(keyboard_check_pressed(vk_return)){
				selected = pre_select;
				playerstate = PlayerState.Grab;
			}
		}
		else {
			// If there's no collision with the required objects, reset pre_select to noone
			pre_select = noone;
		}
		
		// check if hit finished button
		if (place_meeting(obj_vision.x, obj_vision.y, obj_finish_but)){
			if (keyboard_check_pressed(vk_return)){
				playerstate = PlayerState.Idle;
				obj_player2.playerstate = Player2State.Idle;
				obj_gm.gamestate = GameState.CheckResult;
			}
		}
		
	break;
	
	case PlayerState.Grab:
		
		//set object to correct position
		if (current_sprite == spr_player1_rt){
			selected.x = x + 50;
			selected.y = y;
		}
		if (current_sprite == spr_player1_lt){
			selected.x = x - 50;
			selected.y = y;
		}
		if (current_sprite == spr_player1_up){
			selected.x = x;
			selected.y = y - 50;
		}
		if (current_sprite == spr_player1_dw){
			selected.x = x;
			selected.y = y + 50;
		}
		
		if(keyboard_check_pressed(vk_return)){
			
			//specific place holder
			var place_holder_instance = instance_place(selected.x, selected.y, obj_place_holder);
			
			//if it is at the place holder
			if (place_holder_instance != noone){
				obj_gm.place_holder = place_holder_instance;
				
				//if nothing is in the container
				if (!obj_gm.place_holder.container_full){
					//set the selected pos to the place holder pos
					selected.x = obj_gm.place_holder.x;
					selected.y = obj_gm.place_holder.y;
					//set holded to the selected one
					obj_gm.place_holder.holded = selected;
					
					//now its container is full
					obj_gm.place_holder.container_full = true;
					
					//just drop the item to where it is
					playerstate = PlayerState.Drop;
				}
				else{// if something is already in the container
					//move the holded one down 120 pixel
					obj_gm.place_holder.holded.y += 180;
					
					//place the new ones on it
					selected.x = obj_gm.place_holder.x;
					selected.y = obj_gm.place_holder.y;
					
					//set holder to new ones
					obj_gm.place_holder.holded = selected;
					
					//just drop the item to where it is
					playerstate = PlayerState.Drop;
				}
				
			}
			//if it's not at the place
			else{
				//reset place_holder
				obj_gm.place_holder = noone;
				
				//just drop the item to where it is
				playerstate = PlayerState.Drop;
			}
		}
	break;
	
	case PlayerState.Drop:
		selected = noone;
		playerstate = PlayerState.Normal;
	break;
}

player_x= (key_right - key_left) * player_speed;
player_y = (key_down - key_up) * player_speed;

// horizontal movement
if ((key_right - key_left)!=0){
	player_x += (key_right - key_left) * acc;
	if (abs(player_x) > max_velocity){// limit max spped
		player_x = sign(player_x)*max_velocity;
	}
}
else{
	player_x -= sign(player_x) * acc/2
	if ((abs(player_x)) < (acc/2)){
		player_x = 0;
	}
}

// vertical movement
if ((key_down - key_up)!=0){
	player_y += (key_down - key_up) * acc;
	if (abs(player_y) > max_velocity){// limit max spped
		player_y = sign(player_y)*max_velocity;
	}
}
else{
	player_y -= sign(player_y) * acc/2
	if ((abs(player_y)) < (acc/2)){
		player_y = 0;
	}
}


//0.1 is our precision - how close we allow player to get to the object - higher is a  bigger gap
while(abs(player_x) > 0.1) //if the player is moving in horizontal even tho it is running into a wall
{
	player_x *= 0.5; //half x movement
	if(!place_meeting(x + player_x,y, obj_collider))
	{ 

		x += player_x;
		obj_vision.x += player_x;
		if (playerstate == PlayerState.Grab){
			selected.x += player_x;
		}
	}
	else{
		 player_x = 0; //set to zero if there is a collision = 0; //set to zero if there is a collision
	}
}

x += player_x; //now we move
obj_vision.x += player_x;
if (playerstate == PlayerState.Grab){
	selected.x += player_x;
}

//0.1 is our precision - how close we allow player to get to the object - higher is a  bigger gap
while(abs(player_y) > 0.1) //if the player is moving in horizontal even tho it is running into a wall
{
	player_y *= 0.5; //half x movement
	if(!place_meeting(x, y + player_y, obj_collider))
	{ 

		y += player_y;
		obj_vision.y += player_y;
		if (playerstate == PlayerState.Grab){
			selected.y += player_y;
		}
	}
	else{
		 player_y = 0; //set to zero if there is a collision = 0; //set to zero if there is a collision
	}
}

y += player_y; //now we move
obj_vision.y += player_y;
if (playerstate == PlayerState.Grab){
	selected.y += player_y;
}

