/**
 * Check is variable string
 * @param {*} checkedVar any type
 * @returns 	boolean
 */
function isString(checkedVar) {
	return 	Object.prototype.toString.call(checkedVar) === '[object String]' ||
					checkedVar instanceof String;
}

/**
 * Check variable is regular email address
 * @param {*} checkedVar 
 * @returns 	boolean
 */
function isEmail(checkedVar) {  
	return 	isString(checkedVar) &&
					/^([a-z0-9_.+-])+\@(([a-z0-9-])+\.)+([a-z0-9]{2,4})+$/i.test(checkedVar);
}

/**
 * Check variable is regular password
 * 6-20 characters (contains at least one uppercase, lowercase letter and number).
 * @param {*} checkedVar any type
 * @returns		boolean 
 */
function isPassword(checkedVar) {
	return	isString(checkedVar) &&
					/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/.test(checkedVar);
}

/**
 * Check variable is regular international phone number
 * @param {*} checkedVar	any type 
 * @returns		boolean
 */
function isPhoneNumber(checkedVar) {
	return	isString(checkedVar) &&
					/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,5}$/.test(checkedVar);
}

/**
 * Cancel message
 */
function cancel() {
	alert("Meggondoltam magam!");
}