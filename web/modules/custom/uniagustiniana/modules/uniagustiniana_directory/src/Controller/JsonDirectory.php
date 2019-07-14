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
    $query->orderBy('un.field_nivel_value', 'ASC');
    $results = $query->execute()->fetchAll();
    foreach ($results as &$value) {
      if (!is_null($value->fotografia)) {
        $value->fotografia = str_replace('public://', '/sites/default/files/', $value->fotografia);
      }
    }

    $params = Json::encode($results);
    // $params = '[{"id":"253","nivel":"0","nombre":"OSMAR GILBERTO CORREAL CABRAL","ubicacion":null,"fotografia":"\/sites\/default\/files\/2018-09\/correal_0.jpg","cargo":"PRESIDENTE(A) UNIVERSIDAD DE BOYACA","area":"CONSEJO DIRECTIVO","uri":"public:\/\/2018-09\/correal_0.jpg","ciudad":"TUNJA","correo":"osmarcorreal@uniboyaca.edu.co","telefono":"7452854","extension":"5600","dependencia":"174"},{"id":"174","nivel":"2","nombre":"ROSITA CUERVO PAYERAS","ubicacion":"EDIFICIO CENTRAL - PISO 3 - OFICINA 301","fotografia":"\/sites\/default\/files\/2018-09\/rosita_0.jpg","cargo":"RECTORA","area":"RECTOR\u00cdA","uri":"public:\/\/2018-09\/rosita_0.jpg","ciudad":"TUNJA","correo":"rectoria@uniboyaca.edu.co","telefono":"(8) 7450000","extension":"5301","dependencia":null},{"id":"145","nivel":"3","nombre":"MARIA DEL PILAR PEDRAZA DELGADILLO","ubicacion":"Edificio Central - Piso 5 - Oficina 508","fotografia":null,"cargo":"COORDINADORA DE ADMISIONES Y MATR\u00cdCULAS","area":"SECRETAR\u00cdA GENERAL","uri":null,"ciudad":"TUNJA","correo":"mdpedraza@uniboyaca.edu.co","telefono":"(8) 745 0000 ","extension":"9301","dependencia":"174"},{"id":"215","nivel":"3","nombre":"RODRIGO CORREAL CUERVO","ubicacion":"EDIFICIO CENTRAL - PISO 4 - OFICINA 401  ","fotografia":"\/sites\/default\/files\/2018-09\/Ing_Rodrigo.jpg","cargo":"VICERRECTOR ACAD\u00c9MICO","area":"VICERRECTOR\u00cdA ACAD\u00c9MICA","uri":"public:\/\/2018-09\/Ing_Rodrigo.jpg","ciudad":"TUNJA","correo":"rocorreal@uniboyaca.edu.co","telefono":"(8) 7450000","extension":"5400","dependencia":"174"},{"id":"228","nivel":"3","nombre":"CARMENZA MONTA\u00d1EZ TORRES ","ubicacion":"EDIFICIO CENTRAL - PISO 5 - OFICINA 500","fotografia":"\/sites\/default\/files\/2018-09\/Carmenza_0.jpg","cargo":"VICERRECTORA DE EDUCACI\u00d3N VIRTUAL","area":"VICERRECTOR\u00cdA DE EDUCACI\u00d3N VIRTUAL","uri":"public:\/\/2018-09\/Carmenza_0.jpg","ciudad":"TUNJA","correo":"carmenzamt@uniboyaca.edu.co","telefono":"(8) 7450000","extension":"5505","dependencia":"174"},{"id":"242","nivel":"3","nombre":"M\u00d3NICA ALEXANDRA \u00c1LVAREZ MEJ\u00cdA","ubicacion":"EDIFICIO CENTRAL - PISO 3 ","fotografia":null,"cargo":"ASISTENTE RECTOR\u00cdA","area":"RECTOR\u00cdA","uri":null,"ciudad":"TUNJA","correo":"moaalvarez@uniboyaca.edu.co","telefono":"(8) 745 0000 ","extension":"5416","dependencia":"174"},{"id":"247","nivel":"3","nombre":"YEIMY RODR\u00cdGUEZ RODR\u00cdGUEZ","ubicacion":"EDIFICIO CENTRAL - PISO 3 ","fotografia":null,"cargo":"ASESORA JUR\u00cdDICA","area":"OFICINA ASESOR\u00cdA JURIDICA","uri":null,"ciudad":"TUNJA","correo":"yrodriguezr@uniboyaca.edu.co","telefono":"7451908","extension":"5406","dependencia":"174"}]';
    $response = new Response();
    $response->setContent($params);
    $response->headers->set('Content-Type', 'application/json');
    $response->headers->set('Access-Control-Allow-Origin', '*');
    return $response;
  }

}
