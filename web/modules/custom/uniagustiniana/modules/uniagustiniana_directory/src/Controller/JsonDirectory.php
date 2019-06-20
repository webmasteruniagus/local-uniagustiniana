<?php

namespace Drupal\uniagustiniana_directory\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Component\Serialization\Json;
use Symfony\Component\HttpFoundation\Response;
use Drupal\Core\Database\Connection;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Controller routines for page example routes.
 */
class JsonDirectory extends ControllerBase {

  /**
   * Conexión a la base de datos.
   *
   * @var \Drupal\Core\Database\Connection
   */
  private $db;

  /**
   * {@inheritdoc}
   */
  public function __construct(Connection $db) {
    $this->db = $db;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('database')
    );
  }

  /**
   * {@inheritdoc}
   */
  protected function getModuleName() {
    return 'directory_json';
  }

  /**
   * Constructs a simple page.
   *
   * Devuelve un json para la construcion del directorio de la universidad.
   */
  public function viewJson() {
    $query = $this->db->select('users_field_data', 'u');
    $query->addField('u', 'uid', 'id');
    $query->addField('un', 'field_nivel_value', 'nivel');
    $query->addField('unom', 'field_nombres_value', 'nombre');
    $query->addField('ucar', 'field_cargo_value', 'cargo');
    $query->addField('t', 'name', 'area');
    $query->addField('fm', 'uri', 'fotografia');
    $query->addField('ts', 'name', 'sede');
    $query->addField('utel', 'field_telefono_value', 'telefono');
    $query->addField('uext', 'field_extension_value', 'extension');
    $query->addField('ujefe', 'field_jefe_target_id', 'dependencia');
    $query->innerJoin('user__field_organigrama', 'uo', 'u.uid = uo.entity_id AND uo.field_organigrama_value = 1');
    $query->innerJoin('user__field_nivel', 'un', 'u.uid = un.entity_id');
    $query->innerJoin('user__field_nombres', 'unom', 'u.uid = unom.entity_id');
    $query->innerJoin('user__field_cargo', 'ucar', 'u.uid = ucar.entity_id');
    $query->innerJoin('user__field_dependencia', 'udep', 'u.uid = udep.entity_id');
    $query->innerJoin('taxonomy_term_field_data', 't', 'udep.field_dependencia_target_id = t.tid');
    $query->leftJoin('user__user_picture', 'up', 'u.uid = up.entity_id');
    $query->leftJoin('file_managed', 'fm', 'up.user_picture_target_id = fm.fid');
    $query->innerJoin('user__field_sede', 'usede', 'u.uid = usede.entity_id');
    $query->innerJoin('taxonomy_term_field_data', 'ts', 'usede.field_sede_target_id = ts.tid');
    $query->leftJoin('user__field_telefono', 'utel', 'u.uid = utel.entity_id');
    $query->leftJoin('user__field_extension', 'uext', 'u.uid = uext.entity_id');
    $query->leftJoin('user__field_jefe', 'ujefe', 'u.uid = ujefe.entity_id');
    $results = $query->execute()->fetchAll();
    foreach ($results as &$value) {
      if (!is_null($value->fotografia)) {
        $value->fotografia = str_replace('public://', '/sites/default/files/', $value->fotografia);
      }
    }
    $params = Json::encode($results);
    $response = new Response();
    $response->setContent($params);
    $response->headers->set('Content-Type', 'application/json');
    $response->headers->set('Access-Control-Allow-Origin', '*');
    return $response;
  }

}
