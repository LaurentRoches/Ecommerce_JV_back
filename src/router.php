<?php

use src\Services\Routing;

$route = $_SERVER['REDIRECT_URL'];
$methode = $_SERVER['REQUEST_METHOD'];

// ici le :: permet d'appeler la fonction static de la class Routing
$routeComposee = Routing::routeComposee($route);

switch ($route) {
    case HOME_URL:
        // le code ici
        break;
    default:
        // Erreur 404
        break;
}