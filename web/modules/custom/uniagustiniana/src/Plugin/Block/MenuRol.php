<?php

namespace Drupal\uniagustiniana\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Url;
use Drupal\Core\Link;



/**
 * Provides a 'MenuRol' Block.
 *
 * @Block(
 *   id = "MenuRol",
 *   admin_label = @Translation("Menu Rol"),
 * )
 */
class MenuRol extends BlockBase {


    /**
     * {@inheritdoc}
     */

    public function build() {
        $query = db_select('node_field_data', 'n');
        $query->addField('n', 'nid');
        $query->addField('n', 'title');
        $query->join('node__field_home', 'nh', 'n.nid = nh.entity_id');
        $query->condition('n.type', 'page', '=');
        $query->condition('nh.field_home_value', 1, '=');
        $results = $query->execute();
        $current_path = \Drupal::service('path.current')->getPath();
        $path =  explode('/', $current_path);
        $active_menu = false;
        if($path[1] == 'node' && is_numeric($path[2])){
            $active_menu = $path[2];
        }
        $items = [];
        foreach ($results as $result){
            $link = '/node/' . $result->nid;
            $alias = \Drupal::service('path.alias_manager')->getAliasByPath($link);
            $url = Url::fromUri('internal:' . $alias);
            if($active_menu == $result->nid){
                $link_options = array(
                    'attributes' => array(
                        'class' => array(
                            'active',
                        ),
                    ),
                );
                $url->setOptions($link_options);
                $link = Link::fromTextAndUrl($result->title, $url)->toString();
            }else{
                $link = Link::fromTextAndUrl($result->title, $url)->toString();
            }
            $items[] = [
                '#markup' => $link,
                '#wrapper_attributes' => [
                    'class' => [
                        'menu_rol_item',
                    ],
                ],
            ];
        }
        return [
            '#theme' => 'item_list',
            '#list_type' => 'ul',
            '#wrapper_attributes' => [
                'class' => [
                    'wrapper',
                ],
            ],
            '#attributes' => [
                'class' => [
                    'menu_rol',
                ],
            ],
            '#items' => $items,
            '#cache' => ['max-age' => 0],
        ];
    }
}