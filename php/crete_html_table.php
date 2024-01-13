<?php

function creteTable($order, &$html, $message=null) {

	if (!is_string($message) || empty(($message = trim($message))))
		$message = "A tábla üres";

  if (count($order) > 0) {
    $html = 
      "<table style=\"border:1px solid black;\">
        <thead>
          <tr>";
            foreach(array_keys($order[0]) as $key) {
              $html .= 
                "<th style=\"border:1px solid black;\">{$key}</th>";
            }
    $html .= 
         "</tr>
        </thead>
        <tbody>";
      foreach($order as $item) {
        $html .= "<tr>";
        foreach(array_keys($item) as $key) {
          $html .= 
            "<td style=\"border:1px solid black;\">{$item[$key]}</td>";
        }
        $html .= "</tr>";
      }
      $html .=  
        "</tbody>
      </table>";
  } else $html = "<h1>{$message}!</h1>";
}