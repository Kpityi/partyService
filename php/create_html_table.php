<?php

function createTable($order, &$html, $message=null) {

	if (!is_string($message) || empty(($message = trim($message))))
		$message = "A tábla üres";

  if (count($order) > 0) {
    $html = 
      "<table style=\"border:1px solid black;\">
        <thead>
          <tr>
            <td style=\"border:1px solid black;\">
              {{order_number}}: 0000
          <tr>";
            foreach(array_keys($order[0]) as $key) {
              if($key !=='id'){
                $html .= 
                  "<th style=\"border:1px solid black;\">{$key}</th>";
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
              "<td style=\"border:1px solid black;\">{$item[$key]}</td>";
          }
        }
        $html .= "</tr>";        
      }
      $html .=  
        "</tbody>
      </table>";
  } else $html = "<h1>{$message}!</h1>";
}