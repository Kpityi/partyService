<?php
 
// Get arguments
$args = $_POST['data'];
$args= json_decode($args, true, 512, 0);
echo $args;

//Import PHPMailer classes into the global namespace
//These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
 
//required files
require '../../../components/PHPMailer/src/Exception.php';
require '../../../components/PHPMailer/src/PHPMailer.php';
require '../../../components/PHPMailer/src/SMTP.php';
 
//Create an instance; passing `true` enables exceptions


 
$mail = new PHPMailer(true);
  //Set character coding UTF-8
  $mail->CharSet="UTF-8";

  //Server settings
  $mail->isSMTP();                              //Send using SMTP
  $mail->Host       = 'smtp.gmail.com';       //Set the SMTP server to send through
  $mail->SMTPAuth   = true;             //Enable SMTP authentication
  $mail->Username   = 'info.partyservice.mako@gmail.com';   //SMTP write your email
  $mail->Password   = 'jancgahtjjdqeuzv';      //SMTP password
  $mail->SMTPSecure = 'ssl';            //Enable implicit SSL encryption
  $mail->Port       = 465;                                    

  //Recipients
  $mail->setFrom("info.partyservice.mako@gmail.com", "Ábrahám Éva"); // Sender Email and name
  $mail->addAddress($args["email"]);     //Add a recipient email  
  //$mail->addReplyTo($_POST["email"], $_POST["name"]); // reply to sender email

  //Content
  $mail->isHTML(true);               //Set email format to HTML
  $mail->Subject = $args["subject"];   // email subject headings
  $mail->Body    = $args["message"]; //email message
    
  // Success sent message alert
  $mail->send();
