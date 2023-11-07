// Get required input elements, accept button, and modal properties
let inputs    = document.querySelectorAll('input[required]'),
		showHide	= document.getElementById('show-password'),
		acceptBtn	= document.getElementById('accept'),
    passwords = document.querySelectorAll('input-password');

// Add event listener for each required input(s).
inputs.forEach(element => {
	element.addEventListener('input', changed);
});

// Add event listener to show-hide password.
showHide.addEventListener('change', () => {
	passwords.forEach(element => {
		if (showHide.checked)
					element.type = 'text';
		else 	element.type = 'password';
	});
});

// Add event listener accept button.
acceptBtn.addEventListener('click', () => {

	// Crete message
	let msg = ``;

	// Each input elements
	inputs.forEach((element) => {

		// Add to message element identifier, and value
		msg += `${element.id.toUpperCase()}: ${element.value}\n`;
	});

	// Show message
	alert(msg);
});

// Input changed
function changed() {

	// Set auxiliary variable
	let isDisabled = false;

	// Each required input(s)
	inputs.forEach((element) => {

		// Get element identifier, value, belonging to it check mark, and set variable is valid to false
		let key       = element.id,
				value			= element.value.trim(),
				checkMark = element.closest('.input-row').querySelector('.check-mark'),
				isValid   = true;

		// Switch input identifier		
		switch(key) {
			case 'email':
				isValid = isEmail(value);
				break;
			case 'password':
				isValid = isPassword(value);
		}

		// Check mark
		if (isValid)
					checkMark.classList.add('show');
		else  checkMark.classList.remove('show');

		// Check is disabled 
		isDisabled = isDisabled || !isValid;
	});

	// Set accept button 
	acceptBtn.disabled = isDisabled;
}

// Input changed
changed();