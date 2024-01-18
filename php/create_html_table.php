<?php

function createTable($orderNumber, $order, &$html, $message=null) {

	if (!is_string($message) || empty(($message = trim($message))))
		$message = "A tábla üres";

  if (count($order) > 0) {
    $html = 
      "<table>
        <thead>
          <tr>
            <th colspan='3' style='background: black; color: white'>
             {{order_number}}: $orderNumber
            </th>
          </tr>
          <tr>";
            foreach(array_keys($order[0]) as $key) {
              if($key !=='id'){
                $html .= 
                  "<th>{{".$key."}}</th>";
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
            switch ($key){
              case 'ár':
              case 'price':
              case 'Preis':
                $html .= 
              "<td>{{".$item[$key]."}} Ft</td>";
                break;
                case 'mennyiség':
                case 'quantity':
                case 'Menge':
                  $html .= 
                "<td style='text-align: right;'>{{".$item[$key]."}} db</td>";
                  break;
                  default:
                    $html .= 
                      "<td>{{".$item[$key]."}}</td>";
                    break;
            }
          }
        }
        $html .= "</tr>";        
      }
      $html .=  
        "</tbody>
      </table>";
  } else $html = "<h1>{$message}!</h1>";
}