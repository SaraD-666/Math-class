enum Player2State{
	Idle,
	Normal,
	Grab,
	Drop
}

playerstate = Player2State.Normal;

current_sprite = spr_player2_up;

acc = 2;
max_velocity = 10;
player_x = 0;
player_y = 0;
player_speed = 3;

has_created = false;

pre_select = noone;
selected = noone;

