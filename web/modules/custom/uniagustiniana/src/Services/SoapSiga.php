<?php

namespace Drupal\uniagustiniana\Services;

use Drupal\Core\Config\ConfigFactoryInterface;
use SoapClient;
use SoapFault;

/**
 * Clase para ejecutar batch y cron.
 */
class SoapSiga {

  /**
   * Variable para traer configuraciones.
   *
   * @var \Drupal\Core\Config\ConfigFactoryInterface
   */
  protected $configFactory;

  private $token;

  private $tokenAuthentication;

  private $error;

  private $url;

  /**
   * Constructor del formulario.
   */
  public function __construct(ConfigFactoryInterface $config_factory) {
    $this->configFactory = $config_factory->get('uniagustiniana.settings');
    $this->url = 'http://agustinianaprueba.datasae.com/paquetes/WebServices/web/app.php/api/';
  }

  /**
   * Metodo para obtener el token de autenticacion.
   */
  public function getToken() {
    try {
      $client = new Soapclient($this->url . 'obtener_token?wsdl');
      $client_id = 'agustiniana_webservice';
      $secret = 'LcU54XCSqzRU';
      $res = $client->generarToken($client_id, $secret);
      if (is_null($res->access_token)) {
        $error = json_decode($res->ERROR);
        throw new SoapFault("Error", $error->error_description);
      }
      else {
        $this->token = $res->access_token;
      }
    }
    catch (SoapFault $e) {
      $this->error = $e->getMessage();
    }
    return $this;
  }

  /**
   * Token authentication..
   */
  public function getTokenCursos() {
    $this->getToken();
    if (!empty($this->token)) {
      try {
        $client = new Soapclient($this->url . 'usuario?wsdl');
        $res = $client->autenticar($this->token, 'pablovelez', 'hola1234');
        if (is_null($res->TOKEN)) {
          throw new SoapFault("Error", $res->ERROR);
        }
        else {
          $this->tokenAuthentication = $res->TOKEN;
        }
      }
      catch (SoapFault $e) {
        $this->error = $e->getMessage();
      }
    }
    return $this;
  }

  /**
   * Get curses.
   */
  public function getCurses() {
    $this->getTokenCursos();
    if (!empty($this->tokenAuthentication)) {
      try {
        $client = new Soapclient($this->url . 'oferta_academica?wsdl');
        $res = $client->retornarInformacionCursos($this->tokenAuthentication, '2019', 'PREG', '1');
      }
      catch (SoapFault $e) {
        $this->error = $e->getMessage();
      }
    }

    if (!empty($this->error)) {
      drupal_set_message($this->error, 'error');
    }
  }

}
