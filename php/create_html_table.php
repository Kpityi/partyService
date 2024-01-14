<?php

function createTable($orderNumber, $order, &$html, $message=null) {

	if (!is_string($message) || empty(($message = trim($message))))
		$message = "A tábla üres";

  if (count($order) > 0) {
    $html = 
      "<table>
        <thead>
          <tr>
            <td>
  }{order_number}}: $orderNumber
          <tr>";
            foreach(array_keys($order[0]) as $key) {
              if($key !=='id'){
                $html .= 
                  "<th>$key</th>";
              }
            }
    $html .= 
         "</tr>
        </thead>
        <tbody>";
      foreach($order as $item) {
        $html .= "<tr>";
        foreach(array_keys($item) as $key) {
          if($key !=='id'){
            $html .= 
              "<td>$item[$key]</td>";
          }
        }
        $html .= "</tr>";        
      }
      $html .=  
        "</tbody>
      </table>";
  } else $html = "<h1>{$message}!</h1>";
}