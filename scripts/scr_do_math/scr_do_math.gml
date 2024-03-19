function scr_do_math(arr) {
	var equal_index = -1;
    var result = 0;
    var calculation = undefined;
    var currentNumber = "";
    var operation = undefined; // No default operation
	
	// Find the "=" sign index and validate equation format
    for (var i = 0; i < array_length(arr); i++) {
        if (arr[i] == "=") {
			// Multiple "=" signs
            if (equal_index != -1) return "Invalid equation"; 
            equal_index = i;
        }
    }
	
	// "=" at the start or end or not present
	if (equal_index <= 0 || equal_index >= array_length(arr) - 1) {
        return "Invalid equation"; 
    }
	
	// Process expression before "="
    for (var i = 0; i < equal_index; i++) {
        if (is_real(arr[i]) || (is_string(arr[i]) && is_real(string_digits(arr[i])))) {
            // Building the multi-digit number
            currentNumber += string(arr[i]);
        } 
		else if (arr[i] == "+" || arr[i] == "-" || arr[i] == "x" || arr[i] == "/") {
            if (calculation == undefined) {
                // Initialize calculation with the first number
                calculation = real(currentNumber);
            } 
			else if (operation != undefined) {
                // Perform the previous operation with the current number
                switch (operation) {
                    case "+": calculation += real(currentNumber); break;
                    case "-": calculation -= real(currentNumber); break;
                    case "x": calculation *= real(currentNumber); break;
                    case "/": calculation /= real(currentNumber); break;
                }
            }
            operation = arr[i]; // Update operation
            currentNumber = ""; // Reset current number for the next sequence
        }
    }
	
	// Handle the last number before the "=" sign
    if (currentNumber != "") {
        if (calculation == undefined) {
            calculation = real(currentNumber);
        } 
		else if (operation != undefined) {
            switch (operation) {
                case "+": calculation += real(currentNumber); break;
                case "-": calculation -= real(currentNumber); break;
                case "x": calculation *= real(currentNumber); break;
                case "/": calculation /= real(currentNumber); break;
            }
        }
    }
	
	// The result should be the sequence of characters immediately following the "="
    currentNumber = "";
    for (var i = equal_index + 1; i < array_length(arr); i++) {
        if (is_real(arr[i]) || (is_string(arr[i]) && is_real(string_digits(arr[i])))) {
            currentNumber += string(arr[i]);
        } else {
            // If any non-numeric character is found, it's an invalid equation
            return "Invalid equation";
        }
    }
    result = real(currentNumber);
	
	// Check if result matches
    if (calculation == result) {
		global.score += array_length(arr);
		global.score_earned = array_length(arr);
        return "Correct";
    } else {
        return "Wrong";
    }
	
}






/*
function scr_do_math(arr){
	//find equal sign index
	var equal_index = 0;
	var equal_num = 0;
	
	//find all the mathmatical signs
	var arr_sign_index = [];
	var j = 0;
	
	//which side result is on
	var left = false;
	var right = false;
	
	//look for all the signs
	for (var i = 0; i < array_length(arr); i++){
		//=
		if (arr[i] == "="){
			equal_index = i;
			equal_num++;
		}
		
		//+ - x /
		if (arr[i] == "+" || 
			arr[i] == "-" ||
			arr[i] == "x" ||
			arr[i] == "/"){
				
			arr_sign_index[j] = i;
			j++;
		}
		
		/*
		if there's multiple equal sign,
		zero equal sign, 
		equal sign at the beginning of the equation,
		equal sign at the last of the equation,
		invalid equation
		*//*
		if (equal_num > 1 || 
			equal_num < 1 || 
			equal_index == 0 || 
			equal_index == array_length(arr) - 1){
			
			return "Invalid equation";
		}
		
		/*
		if there's no signs at all,
		if there's sign in the first place,
		if any two signs are adjacent,
		if they are right next to the equal sign
		if both size of equal sign have mathmatic signs,
		if there's sign in the last place,
		*//*
		for(var k = 0; k < array_length(arr_sign_index); k++){
			//know which side the result is on
			if (arr_sign_index[k] < equal_index){
				right = true;
			}
			else if (arr_sign_index[k] > equal_index){
				left = true;
			}
			
			if (array_length(arr_sign_index) == 0 || //no signs
				arr_sign_index[k] == 0 || //first
				((k != array_length(arr_sign_index)) && (arr_sign_index[k]+1 == arr_sign_index[k+1])) || //if two are adjacent
				arr_sign_index[k] == equal_index - 1 || //at the left of equal
				arr_sign_index[k] == equal_index + 1 || //at the right of equal
				(right && left) || //exist both size of equala
				arr_sign_index[k] == array_length(arr) - 1){ //last
		 			
				return "Invalid equation";
			}
			
		}
		
		//if the equation is valid, then check for if they are getting the right answer
		//if result is on the right, then calculate left
		if (right){
			//loop through the left side
			for (var k = 0; k < equal_index; k++){
				var val = arr[k];
			}
		}
		
	}
}
*/