// Get required input elements, accept button, get today separated, and modal properties
let inputs    = document.querySelectorAll('input[required], textarea[required]'),
		gender    = [...inputs].filter(e => e.id === 'female' || e.id === 'male'),
		email 		= [...inputs].filter(e => e.id === 'email')[0],
		password  = [...inputs].filter(e => e.id === 'password')[0],
    passwords = [...inputs].filter(e => e.classList.contains('input-password')),
		born			= [...inputs].filter(e => e.id === 'born')[0],
		showHide	= document.getElementById('show-password'),
		acceptBtn = document.getElementById('accept'),
		today 		= dateSeparate(new Date());

// Set input born min, max values
[{key: 'min', num: 120}, {key: 'max', num: 18}].forEach(item => {

	// Calculate date
	let date 	= (today.year - item.num) + '-' + 
							('00' + today.month).slice(-2) + '-' + 
							('00' + today.day).slice(-2);

	// Check is valid
	if (!isDate(new Date(date))) {

		// Set date before one day
		date 	= (today.year - item.num) + '-' + 
						('00' + today.month-1).slice(-2) + '-01';
	}

	// Set limit
	born[item.key] = date;
});

// Add event listener for each required input(s).
inputs.forEach(element => {

	// Check input type
	if (element.type === 'radio')
				element.addEventListener('change', changed);
	else	element.addEventListener('input', changed);
});

// Add event listener to show-hide password.
showHide.addEventListener('change', () => {

	// Each passwords
	passwords.forEach(element => {

		// When checked, then set type to text, otherwise set to password
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

		// Get element identifier
		let key = element.id;

		// Skip not necessary elements
		if (!['email2', 'password2'].includes(key) &&
				(element.type !== 'radio' || element.checked)) {

			// Define value variable
			let value;

			// Switch input identifier
			switch(key) {
				case 'male':
				case 'female':
					
					// Capitalize identifier, and chang key
					value = key.charAt(0).toLocaleUpperCase() + key.substring(1);
					key 	= 'gender';
					break;
				case 'address':

					// Remove tabulators
					value = element.value.replace(/\t/g, '');
					break;
				default:
					value = element.value;
			}

			// Add to message key, and value
		  msg += `${key}: ${value}\n`;
		}
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
			case 'born':
				let born = dateSeparate(new Date(value));
				if ((isValid = born !== null)) {
					let age 	= today.year - born.year,
    					month = today.month - born.month,
							day		= today.day - today.day;
    			if (month < 0 || (month === 0 && day < 0)) 
						age--;
					isValid = age >= 18 && age <= 120;
    		}
				break;
			case 'male':
			case 'female':
				isValid = gender[0].checked || gender[1].checked;
				break;
			case 'tel':
				isValid = isPhoneNumber(value);
				break;
			case 'email':
			case 'email2':
				isValid = isEmail(value) && 
									(key !== 'email2' || value === email.value.trim()); 
				break;
			case 'password':
			case 'password2':
				isValid = isPassword(value) &&
									(key !== 'password2' || value === password.value.trim());
				break;
			default:
				isValid = value.length;
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