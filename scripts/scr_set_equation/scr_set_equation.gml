// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_set_equation(arr_holder, arr_equation){
	var j = 0;
	//loop through arr_holder
	for (var i = 0; i < array_length(arr_holder); i++){
		//if arr_holder[i] is not null, add it to the end of arr_equation
		if (arr_holder[i].holded != noone){
			arr_equation[j] = arr_holder[i].holded.values;
			j++;
		}
	}
}