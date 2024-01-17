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
$query = "SELECT MAX(`order_id`) AS `order_id` 
			FROM `orders` 
			LIMIT 1;";

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
	"{{lang_id}}"				=> $args['lang']['id'],
  "{{user_name}}"			=> $args['userName'],
	"{{current_date}}"	=> date("Y-m-d"),
	"{{shipping_cost}}"	=> strval($args['shipping']) ,
	"{{total_price}}"		=> strval($args['total']),
	"{{table-content}}"	=> ""
);

if (count($args["cart"])) {
	foreach(array_keys($args["cart"][0]) as $key) {
		$langData["{{".$key."}}"] = $key;
	}
	foreach($args["cart"] as $item){
		foreach(array_keys($item) as $key){
			$langData["{{".$item[$key]."}}"] = $item[$key];
		}
	}
}

$langData["{{succesful_order}}"] 	= "succesful_order";
$langData["{{order_number}}"] 		= "order_number";
$langData["{{dear}}"] 						= "dear";
$langData["{{thank_order}}"] 			= "thank_order";
$langData["{{shipping}}"] 				= "shipping";
$langData["{{total}}"] 						= "total";

// Merge language with constants
$langData = $lang->translate($langData);

createTable($result['order_id'], $args["cart"], $constants["{{table-content}}"]);

$langData = Util::objMerge($langData, $constants);

$constants["{{table-content}}"] = 
	strtr($constants["{{table-content}}"], $langData);

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
  $phpMailer->Subject 	= $langData["{{succesful_order}}"];
  $phpMailer->Body 		= $phpMailer->getDocument();
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
Util::setResponse('email_sent_succesfull');
}

// Close connection
$db = null;

// Set response
Util::setResponse($result);