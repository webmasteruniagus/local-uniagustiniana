<?php

namespace Drupal\uniagustiniana\Services;

use Drupal\Core\Config\ConfigFactoryInterface;
use Drupal\Core\Database\Connection;
use Drupal\Core\Render\RendererInterface;
use Drupal\Core\Mail\MailManagerInterface;
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
  /**
   * Variable para formatear conexion con la base de datos.
   *
   * @var \Drupal\Core\Database\Connection
   */
  protected $database;
  /**
   * The renderer service.
   *
   * @var \Drupal\Core\Render\RendererInterface
   */
  protected $renderer;
  /**
   * The mail manager.
   *
   * @var \Drupal\Core\Mail\MailManagerInterface
   */
  protected $mailManager;

  private $token;

  private $tokenAuthentication;

  private $error;

  private $url;

  /**
   * Constructor del formulario.
   */
  public function __construct(ConfigFactoryInterface $config_factory, Connection $connection, RendererInterface $renderer, MailManagerInterface $mail_manager) {
    $this->configFactory = $config_factory->get('uniagustiniana.settings');
    $this->database = $connection;
    $this->renderer = $renderer;
    $this->mailManager = $mail_manager;
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
        // '2019', 'PREG', '1.
        $res = $client->retornarInformacionCursos($this->tokenAuthentication, '2019');
        $module = 'uniagustiniana';
        $key = 'notification';
        $to = 'culma6@gmail.com';
        if (!empty($res->PROGRAMAS)) {
          $ids = [];
          $rows = [];
          foreach ($res->PROGRAMAS as $value) {
            $ids[] = $value['programa_codigo'];
            $rows[$value['programa_codigo']] = [
              'codigo' => $value['programa_codigo'],
              'nombre' => $value['programa_nombre'],
              'facultad' => $value['programa_facultad'],
              'sede' => $value['programa_sede'],
            ];
          }
          $query = $this->database->select('commerce_product__field_codigo_siga', 'cpfc');
          $query->addField('cpfc', 'field_codigo_siga_value');
          $query->condition('cpfc.field_codigo_siga_value', $ids, 'IN');
          $results = $query->execute()->fetchAll();
          foreach ($results as $result) {
            unset($rows[$result->field_codigo_siga_value]);
          }
          $header = [
            'codigo' => 'Codigo',
            'nombre' => 'Nombre',
            'facultad' => 'Facultad',
            'sede' => 'Sede',
          ];
          $table['table'] = [
            '#type' => 'table',
            '#header' => $header,
            '#attributes' => [
              'border' => '1',
            ],
            '#rows' => $rows,
            '#empty' => 'No se encontro información',
          ];
          $params['message'] = $this->renderer->render($table);
          $params['title'] = 'Programas siga que no existen en el portal';
        }
        else {
          $params['message'] = 'No se encontraron programas';
          $params['title'] = 'Error al conectarse con el servicio SIGA';
        }
        $this->mailManager->mail($module, $key, $to, "es", $params, NULL, TRUE);
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
