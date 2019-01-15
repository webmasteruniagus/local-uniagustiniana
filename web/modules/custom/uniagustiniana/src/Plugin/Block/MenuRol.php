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
        $query = db_select('groups_field_data', 'g');
        $query->addField('g', 'id');
        $query->addField('g', 'label');
        $query->condition('g.type', 'home', '=');
        $results = $query->execute();
        $current_path = \Drupal::service('path.current')->getPath();
        $path =  explode('/', $current_path);
        $active_menu = false;
        if($path[1] == 'group' && is_numeric($path[2])){
            $active_menu = $path[2];
        }
        $items = [];
        $alias = \Drupal::service('path.alias_manager')->getAliasByPath('/noticias');
        $url = Url::fromUri('internal:' . $alias);

        $link = Link::fromTextAndUrl('Noticias', $url)->toString();

        $items[] = [
            '#markup' => $link,
            '#wrapper_attributes' => [
                'class' => [
                    'menu_rol_item menu-item',
                ],
            ],
        ];
        $alias = \Drupal::service('path.alias_manager')->getAliasByPath('/eventos');
        $url = Url::fromUri('internal:' . $alias);

        $link = Link::fromTextAndUrl('Eventos', $url)->toString();

        $items[] = [
            '#markup' => $link,
            '#wrapper_attributes' => [
                'class' => [
                    'menu_rol_item menu-item',
                ],
            ],
        ];
        foreach ($results as $result){
            $link = '/group/' . $result->id;
            $alias = \Drupal::service('path.alias_manager')->getAliasByPath($link);
            $url = Url::fromUri('internal:' . $alias);
            if($active_menu == $result->id){
                $link_options = array(
                    'attributes' => array(
                        'class' => array(
                            'active',
                        ),
                    ),
                );
                $url->setOptions($link_options);
                $link = Link::fromTextAndUrl($result->label, $url)->toString();
            }else{
                $link = Link::fromTextAndUrl($result->label, $url)->toString();
            }
            $items[] = [
                '#markup' => $link,
                '#wrapper_attributes' => [
                    'class' => [
                        'menu_rol_item menu-item',
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
