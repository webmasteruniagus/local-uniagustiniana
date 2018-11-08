<?php

namespace Drupal\uniagustiniana\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Url;
use Drupal\Core\Link;



/**
 * Provides a 'ProgramasFacultad' Block.
 *
 * @Block(
 *   id = "ProgramasFacultad",
 *   admin_label = @Translation("Programas de facultad"),
 * )
 */
class ProgramasFacultad extends BlockBase {


  /**
   * {@inheritdoc}
   */

  public function build() {
    $current_path = \Drupal::service('path.current')->getPath();
    $path = explode('/', $current_path);
    if($path[1] == 'group' && is_numeric($path[2])){
        $query = db_select('groups_field_data', 'gd');
        $query->addField('gd', 'id');
        $query->addField('gd', 'label');
        $query->leftJoin('group__field_metodologia', 'gfm', 'gd.id = gfm.entity_id');
        $query->addField('gfm', 'field_metodologia_value');
        $query->leftJoin('group__field_total_creditos', 'gftc', 'gd.id = gftc.entity_id');
        $query->addField('gftc', 'field_total_creditos_value');
        $query->leftJoin('group__field_tipo_de_formacion', 'gftf', 'gd.id = gftf.entity_id');
        $query->addField('gftf', 'field_tipo_de_formacion_value');
        $query->leftJoin('group__field_perfil_profesional', 'gfpp', 'gd.id = gfpp.entity_id');
        $query->addField('gfpp', 'field_perfil_profesional_value');
        $query->innerJoin('group__field_facultad', 'gff', 'gd.id = gff.entity_id');
        $query->leftJoin('group__field_nivel_de_formacion', 'gnf', 'gd.id = gnf.entity_id');
        $query->leftJoin('taxonomy_term_field_data', 'td', 'gnf.field_nivel_de_formacion_target_id = td.tid');
        $query->addField('td', 'name');
        $query->leftJoin('group__field_sede', 'gfs', 'gd.id = gfs.entity_id');
        $query->leftJoin('taxonomy_term_field_data', 'tds', 'gfs.field_sede_target_id = tds.tid');
        $query->addField('tds', 'name');
        $query->condition('gd.type', 'programa', '=');
        $query->condition('gff.field_facultad_target_id', $path[2], '=');
        $result=$query->execute()->fetchAll();
        return [
            '#theme' => 'programas_facultad',
            '#programas' => $result,
            '#cache' => [
                'max-age' => 0
            ]
        ];
    }
    return [];
  }
}