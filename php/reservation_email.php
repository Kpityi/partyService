<?php
 declare(strict_types=1);

 // Use namescapes aliasing
use Util\Util as Util;
use Database\Database as Database;
use Language\Language as Language;
use Document\Document as Document;
use Document\Tag as Tag;
use PHPMailer\Email as Email;

// Set environment
require_once('../../common/php/environment.php');


// Get arguments
$args = Util::getArgs();


// Create email
$phpMailer = new Email();
 
  
//Add rest properties
$phpMailer->Subject = $args["subject"];   // email subject headings
$phpMailer->Body    = $args["message"]; //email message
$phpMailer->addAddress($args["email"]);     //Add a recipient email  
  
    
// Success sent message alert
$phpMailer->send();

// Close email
$phpMailer = null;

echo 'ok';