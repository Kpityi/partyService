<?php
 declare(strict_types=1);

 // Use namescapes aliasing
use Util\Util as Util;
use Language\Language as Language;
use PHPMailer\Email as Email;

// Set environment
if (!isset($GLOBALS['___app___'])) 
  require_once('../common/php/environment.php');


// Get arguments
$args = Util::getArgs();

// Set language
$lang = new Language($args['lang']);

// Translate error messages
$errorMsg = $lang->translate(Email::$errorMessages);

// Set constants data
$constants = array(
	"{{lang_id}}" 		=> $args['lang']['id'],
 	 "{{user_name}}"    => $args['userName'],
	"{{current_date}}" 	=> date("Y-m-d"),
);

// Merge language with constants
$langData = $lang->translate(array(
  "{{succesful_reservation}}"	=> "succesful_reservation",
  "{{username}}"                => $args['userName']
));
$langData = Util::objMerge($langData, $constants);

// Create email
$phpMailer = new Email($lang);

// Check is error
if ($phpMailer->isError()) {

	// Set error
	Util::setError("{$phpMailer->getErrorMsg()}!", $phpMailer, $lang);
}

// Set document
$phpMailer->setDocument(array(
	'fileName'		=> "reservation_email.html",
	'subFolder' 	=> 'html/email'
), $constants, $langData);

// Check is error
if ($phpMailer->isError()) {

	// Set error
	Util::setError("{$phpMailer->getErrorMsg()}!", $phpMailer, $lang);
}

// Close language
$lang = null;

try {

	// Add rest properties
  $phpMailer->Subject 	= $langData["{{succesful_reservation}}"];
  $phpMailer->Body 			= $phpMailer->getDocument();
  $phpMailer->addAddress($args['email'], 
                         $langData["{{user_name}}"]);

	// Send email
  $phpMailer->send();

// Exception
} catch (Exception $e) {

  // Set error
	Util::setError("{$errorMsg['email_send_failed']}!", $phpMailer);
}

// Close email
$phpMailer = null;

// Set response
Util::setResponse('email_sent_succesful');

 
 
  
    
