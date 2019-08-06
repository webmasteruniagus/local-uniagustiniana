<?php

namespace Drupal\uniagustiniana\Plugin\Block;

use Drupal\block\Entity\Block;
use Drupal\Core\Block\BlockBase;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Drupal\Core\Entity\EntityViewBuilderInterface;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\Core\Database\Connection;
use Drupal\Core\Path\CurrentPathStack;
use Drupal\user\PrivateTempStoreFactory;

/**
 * Provides a 'MenuAccount' Block.
 *
 * @Block(
 *   id = "MainMenu",
 *   admin_label = @Translation("Main Menu"),
 * )
 */
class MainMenu extends BlockBase implements ContainerFactoryPluginInterface {

  /**
   * The block view builder.
   *
   * @var \Drupal\Core\Entity\EntityViewBuilderInterface
   */
  protected $blockViewBuilder;
  /**
   * Variable para formatear conexion con la base de datos.
   *
   * @var \Drupal\Core\Database\Connection
   */
  protected $database;
  /**
   * Protected currentPath variable.
   *
   * @var Drupal\Core\Path\CurrentPathStack
   */
  protected $currentPath;
  /**
   * Variables de sesion.
   *
   * @var Drupal\user\PrivateTempStoreFactory
   */
  protected $tempStore;

  /**
   * {@inheritdoc}
   */
  public function __construct(array $configuration, $plugin_id, $plugin_definition, EntityViewBuilderInterface $block_view_builder, Connection $connection, CurrentPathStack $currentPath, PrivateTempStoreFactory $temp_store_factory) {
    parent::__construct($configuration, $plugin_id, $plugin_definition);
    $this->blockViewBuilder = $block_view_builder;
    $this->database = $connection;
    $this->currentPath = $currentPath;
    $this->tempStore = $temp_store_factory->get('uniagustiniana');
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition) {
    return new static(
      $configuration,
      $plugin_id,
      $plugin_definition,
      $container->get('entity.manager')->getViewBuilder('block'),
      $container->get('database'),
      $container->get('path.current'),
      $container->get('user.private_tempstore')
    );
  }

  /**
   * {@inheritdoc}
   */
  public function build() {
    $current_path = $this->currentPath->getPath();
    // Virtualidad.
    if ($current_path == '/group/90') {
      $this->tempStore->set('main_menu', $current_path);
      $name = 'mainnavegationevu';
    }
    // Suba.
    elseif ($current_path == '/group/57') {
      $this->tempStore->set('main_menu', $current_path);
      $name = 'mainnavigationsuba';
    }
    // Menu principal.
    elseif ($current_path == '/group/61') {
      $this->tempStore->set('main_menu', FALSE);
      $name = 'mainnavigation';
    }
    else {
      $session_path = $this->tempStore->get('main_menu') ?? FALSE;
      if ($session_path) {
        $query = $this->database->select('menu_link_content_data', 'mlc');
        $query->addField('mlc', 'menu_name');
        $query->join('menu_link_content_data', 'mlc1', 'mlc.menu_name = mlc1.menu_name');
        $query->condition('mlc.link__uri', '%' . $session_path . '%', 'LIKE');
        $query->condition('mlc1.link__uri', '%' . $current_path . '%', 'LIKE');
        $result = $query->execute()->fetchObject();
        $name = 'mainnavigation';
        if ($result) {
          if ($result->menu_name == 'main-navigation-suba') {
            $name = 'mainnavigationsuba';
          }
          elseif ($result->menu_name == 'main-navegation-evu') {
            $name = 'mainnavegationevu';
          }
        }
      }
      else {
        $name = 'mainnavigation';
      }
    }

    $block = Block::load($name);
    $block_content = $this->blockViewBuilder->view($block);

    return [
      '#type' => 'container',
      "element-content" => $block_content,
      '#weight' => 0,
      '#cache' => ['max-age' => 0],
    ];
  }

}
