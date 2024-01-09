<?php
 declare(strict_types=1);

 // Use namescapes aliasing
use Util\Util as Util;
use Language\Language as Language;
use Document\Document as Document;
use PHPMailer\Email as Email;

// Set environment
require_once('../../common/php/environment.php');


// Get arguments
$args = Util::getArgs();

// Set language
$lang 		= new Language($args['langId'], $args['langType']);
$language = $lang->translate(array(
  "%email_do_not_reply%" => "email_do_not_reply",
  "%succesfull_reservation%"=>"succesfull_reservation",
  "%dear%"=>"dear",
  "%thanks_for_reservation%"=>"thanks_for_reservation",
  "email_send_failed" => "email_send_failed",
  "email_crete_failed" => "email_crete_failed",
	"file_name_missing"=> "file_name_missing",
	"file_not_found" => "file_not_found",
	"file_unable_to_read" => "file_unable_to_read"
));
$language["%lang_id%"] = $args['langId'];
$language["%user_name%"] = $args['userName'];
$language["%current_date%"] = date("Y-m-d");
$language["%current_year%"] = date("Y");
$lang = null;

// Create document
$document = Document::createDocument('reservation_email.html', $language, 'html/email');

// Check has error
if (!is_null($document["error"])) {

	// Get error message, and set error
	Util::setError("{$document["error"]}\n{$message}");
}

// Create email
$phpMailer = new Email();

// // Check is not created
if ($phpMailer->isError()) {

	// Set error
	Util::setError("{$language['email_crete_failed']}!\n{$message}", $phpMailer);
}

// Get image
$imgFile = searchForFile('logo.png', 'media/image/logo');

try {

  // Check image found
	if (!is_null($imgFile)) {
  	$phpMailer->AddEmbeddedImage($imgFile, 'logoimg');
	}

  
  //Add rest properties
  $phpMailer->Subject = $language["%succesfull_reservation%"];   // email subject headings
  $phpMailer->Body    = $document["content"]; //email message
  $phpMailer->addAddress($args['email']);     //Add a recipient email  
  
    
  // send message 
  $phpMailer->send();

// Exception
} catch (Exception $e) {

  // Set error
	Util::setError("{$language['email_send_failed']}!\n{$message}", $phpMailer);
}

// Close email
$phpMailer = null;

// Set response
Util::setResponse('email_sent_succesfull');
 
 
  
    
