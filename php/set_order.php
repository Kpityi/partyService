<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;
use Language\Language as Language;
use PHPMailer\Email as Email;

// Set environment
if (!isset($GLOBALS['___app___'])) 
  require_once('../../common/php/environment.php');

require_once('create_html_table.php');


// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

// Set query
$query = "SELECT MAX(`order_id`) as `order_id` FROM `orders` LIMIT 1;";

// Execute query with argument
$result = $db->execute($query);

if (is_null($result[0]['order_id']))
			$orderId = '0001';
else 	$orderId = substr(('0000' . strval(intval($result[0]['order_id'])+1)), -4);

// Set query
$query = "INSERT INTO `orders` (`product_id`,`product_name`,`price`,`quantity`,`user_id`, `order_id`) VALUES ";

$params = array();
foreach($args['cart'] as $item) {
	$item['user_id'] = $args['userId'];
	$item['order_id'] = $orderId;
	$params = array_merge($params, array_values($item));
}

// Execute query with argument
$result = $db->execute($query, $params);
if ($result['affectedRows']>0) {
	$result['order_id'] = date("Y/m/d") . "/" . $orderId;
	
// Set language
$lang = new Language($args['lang']);

// Translate error messages
$errorMsg = $lang->translate(Email::$errorMessages);

// Set constants data
$constants = array(
	"{{lang_id}}" 					=> $args['lang']['id'],
  "{{user_name}}"        => $args['userName'],
	"{{current_date}}" 			=> date("Y-m-d"),
	"{{table-content}}"     => ""
);

// Merge language with constants
$langData = $lang->translate(array(
  "{{succesful_order}}"			=> "succesful_order",
  "{{username}}"            => $args['userName'],
	"{{shipping_cost}}"				=> $args['shipping'],
	"{{total_prise}}"					=> $args['total']
));
$langData = Util::objMerge($langData, $constants);

createTable($result['order_id'], $args["cart"], $constants["{{table-content}}"]);

// Create email
$phpMailer = new Email($lang);

// Check is error
if ($phpMailer->isError()) {

	// Set error
	Util::setError("{$phpMailer->getErrorMsg()}!", $phpMailer, $lang);
}

// Set document
$phpMailer->setDocument(array(
	'fileName'		=> "order_email.html",
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
  $phpMailer->Subject = $langData["{{succesful_order}}"];
  $phpMailer->Body 		= $phpMailer->getDocument();
  $phpMailer->addAddress($args['email'], 
                         $langData["{{username}}"]);

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
Util::setResponse('email_sent_succesfull');
}

// Close connection
$db = null;

// Set response
Util::setResponse($result);