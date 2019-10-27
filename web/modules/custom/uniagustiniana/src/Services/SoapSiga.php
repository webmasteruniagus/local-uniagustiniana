<?php

namespace Drupal\uniagustiniana\Services;

use Drupal\Core\Config\ConfigFactoryInterface;
use Drupal\Core\Database\Connection;
use Drupal\Core\Render\RendererInterface;
use Drupal\Core\Mail\MailManagerInterface;
use Drupal\Core\Entity\EntityTypeManagerInterface;
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
  /**
   * Servicio para cargar entidad.
   *
   * @var \Drupal\Core\Entity\EntityTypeManagerInterface
   */
  protected $entityTypeManager;

  private $token;

  private $tokenAuthentication;

  private $error;

  private $url;

  private $info;

  /**
   * Constructor del formulario.
   */
  public function __construct(ConfigFactoryInterface $config_factory, Connection $connection, RendererInterface $renderer, MailManagerInterface $mail_manager, EntityTypeManagerInterface $entity_type_manager) {
    $this->configFactory = $config_factory->get('uniagustiniana.settings');
    $this->info = $this->configFactory->get('siga');
    $this->database = $connection;
    $this->renderer = $renderer;
    $this->mailManager = $mail_manager;
    $this->entityTypeManager = $entity_type_manager;
    $this->url = $this->info['url'];
  }

  /**
   * Metodo para obtener el token de autenticacion.
   */
  public function getToken() {
    try {
      $client = new Soapclient($this->url . 'obtener_token?wsdl');
      $client_id = $this->info['client_id'];
      $secret = $this->info['secret'];
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
        $res = $client->autenticar($this->token, $this->info['usuario'], $this->info['clave']);
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
        $to = $this->info['email'];
        if (!empty($res->PROGRAMAS)) {
          $rows = [];
          foreach ($res->PROGRAMAS as $value) {
            $rows[$value['programa_codigo']] = [
              'codigo' => $value['programa_codigo'],
              'nombre' => $value['programa_nombre'],
              'facultad' => $value['programa_facultad'],
              'sede' => $value['programa_sede'],
              'url' => $value['url_inscripcion'],
            ];
          }
          $products = $this->entityTypeManager->getStorage('commerce_product')->loadMultiple();
          foreach ($products as $product) {
            $idSiga = $product->get('field_codigo_siga')->getValue();
            if (isset($rows[$idSiga[0]['value']])) {
              $product->set('field_curso_activo', 1);
              $product->set('field_enlace_a_siga', [
                'uri' => $rows[$idSiga[0]['value']]['url'],
                'title' => 'Enlace',
              ]);
              unset($rows[$idSiga[0]['value']]);
            }
            else {
              $product->set('field_curso_activo', 0);
            }
            $product->save();
          }
          $header = [
            'codigo' => 'Codigo',
            'nombre' => 'Nombre',
            'facultad' => 'Facultad',
            'sede' => 'Sede',
            'url' => 'URL',
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
          $params['message'] = $this->renderer->renderPlain($table);
          $params['title'] = 'Programas siga que no existen en el portal';
        }
        else {
          $params['message'] = 'No se encontraron programas';
          $params['title'] = 'Error al conectarse con el servicio SIGA';
        }
        if ($rows) {
          $this->mailManager->mail($module, $key, $to, "es", $params, NULL, TRUE);
        }
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
