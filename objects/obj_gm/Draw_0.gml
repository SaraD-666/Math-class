//show the ui
instance_create_layer(64, 51, "UI", obj_score);
draw_set_color(c_black);
draw_set_font(fnt_txt);
draw_text(obj_score.x - 15, obj_score.y - 20, global.score);

switch(gamestate){
	case GameState.InProgress:
	break;
	
	case GameState.CheckResult:
		not_print = true;
		result = noone;
		obj_finish_but.image_alpha = 1;
		//create the equation array
		scr_set_equation(arr_place_holders, arr_equation);
		
		if (not_print){
			show_debug_message(arr_equation);
			not_print = false;
		}
		
		result = scr_do_math(arr_equation);
		
		if (result != noone){
			gamestate = GameState.ShowScore;
		}
	
	break;
	
	case GameState.ShowScore:
		instance_create_layer(683,384, "UI", obj_final);
		
		if (result == "Invalid equation"){
			draw_set_color(c_black);
			draw_text(obj_final.x - 600, obj_final.y - 60, "I think your elementary math teacher is gonna be mad about you");
			draw_text(obj_final.x - 600, obj_final.y, "for not knowing how to write a proper equation...");
			draw_text(obj_final.x - 300, obj_final.y + 60, "Press c to continue.");
			
			if (keyboard_check_pressed(ord("C"))){
				room_restart();
			}
		}
		
		if (result == "Correct"){
			var str = "your score is " + string(global.score - global.score_earned) + " + " + string(global.score_earned);
			
			draw_set_color(c_black);
			draw_text(obj_final.x - 300, obj_final.y - 60, "Nice work!");
			draw_text(obj_final.x - 300, obj_final.y, str);
			draw_text(obj_final.x - 300, obj_final.y + 60, "Press c to continue.");
			
			if (keyboard_check_pressed(ord("C"))){
				room_restart();
			}
		}
		
		if (result == "Wrong"){
			global.score_earned = 0;
			var str = "your score is " + string(global.score) + " + " + string(global.score_earned);
			
			draw_set_color(c_black);
			draw_text(obj_final.x - 300, obj_final.y - 60, "Womp womp...gotta to better math next time");
			draw_text(obj_final.x - 300, obj_final.y, str);
			draw_text(obj_final.x - 300, obj_final.y + 60, "Press c to continue.");
			
			if (keyboard_check_pressed(ord("C"))){
				room_restart();
			}
		}
		
	break;
}



