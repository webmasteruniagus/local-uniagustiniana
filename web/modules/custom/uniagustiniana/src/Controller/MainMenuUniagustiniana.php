<?php

/**
 * Created by PhpStorm.
 * User: andres
 * Date: 7/02/18
 * Time: 10:12 AM
 */
namespace Drupal\uniagustiniana\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Menu\MenuLinkTreeInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Drupal\Core\Menu\MenuTreeParameters;
use Drupal\Core\Link;
use Drupal\Core\Url;

class MainMenuUniagustiniana extends ControllerBase
{
    /**
     * The menu link tree service.
     *
     * @var \Drupal\Core\Menu\MenuLinkTreeInterface
     */
    protected $menuLinkTree;

    /**
    * @param \Drupal\Core\Menu\MenuLinkTreeInterface $menu_link_tree
    *   The menu link tree service.
    */
    public function __construct(MenuLinkTreeInterface $menu_link_tree) {
        $this->menuLinkTree = $menu_link_tree;
    }

    /**
     * {@inheritdoc}
     */
    public static function create(ContainerInterface $container) {
        return new static(
            $container->get('menu.link_tree')
        );
    }
    /**
    * Provide the administration overview page.
    *
    * @param string $link_id
    *   The ID of the administrative path link for which to display child links.
    *
    * @return array
    *   A renderable array of the administration overview page.
    */
    public function Uniagustiniana($link_id) {
        $parameters = new MenuTreeParameters();
        $parameters->setRoot($link_id)->excludeRoot()->setTopLevelOnly()->onlyEnabledLinks();
        $tree = $this->menuLinkTree->load(NULL, $parameters);
        $manipulators = [
            ['callable' => 'menu.default_tree_manipulators:checkAccess'],
            ['callable' => 'menu.default_tree_manipulators:generateIndexAndSort'],
        ];
        $tree = $this->menuLinkTree->transform($tree, $manipulators);
        $items = [];
        foreach ($tree as $key => $element) {

            // Only render accessible links.
            if (!$element->access->isAllowed()) {
                continue;
            }

            $link = $element->link;
            $package = $link->getRouteParameters();
            $title = $link->getTitle();
            $description = $link->getDescription();
            $route = $element->link->getRouteName();
            $url = Url::fromRoute($route);
            $item[$package['package']][] = [
                '#type' => 'markup',
                '#markup' => Link::fromTextAndUrl($title, $url)->toString(),
                '#suffix' => "<div>" . $description . "</div>"
            ];
            $items[$package['package']] = [
                '#title' => $package['package'],
                '#theme' => 'item_list',
                '#attributes' => array('class' => array('item-main-menu')),
                '#items' => $item[$package['package']]
            ];
        }
        return $items;
    }
}
