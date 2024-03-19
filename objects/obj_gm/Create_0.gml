could_place = false;
place_holder = noone;

arr_place_holders = [];
arr_equation = [];

result = noone;

not_print = true;

//generate a bunch place holders
//224 192 352 192
for (var i = 0; i < 8; i++){
	arr_place_holders[i] = instance_create_layer(224 + i * 128, 192, "Instances", obj_place_holder);
}
show_debug_message(arr_place_holders);


enum GameState{
	InProgress,
	CheckResult,
	ShowScore
}

gamestate = GameState.InProgress;
