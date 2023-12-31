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
$phpMailer->Subject = "contact";   // email subject headings
$phpMailer->Body    = "email: ".$args["email"]." message: ". $args["message"]; //email message
$phpMailer->addAddress("info.partyservice.mako@gmail.com");     //Add a recipient email  
  
    
// Success sent message alert
$phpMailer->send();

// Close email
$phpMailer = null;

echo 'send';