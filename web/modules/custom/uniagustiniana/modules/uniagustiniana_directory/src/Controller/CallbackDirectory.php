<?php

namespace Drupal\uniagustiniana_directory\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\Request;
use Drupal\Core\Extension\ModuleHandlerInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Controller routines for page example routes.
 */
class CallbackDirectory extends ControllerBase {

  /**
   * The module handler.
   *
   * @var \Drupal\Core\Extension\ModuleHandlerInterface
   */
  protected $moduleHandler;

  /**
   * Contructor del controlador.
   */
  public function __construct(ModuleHandlerInterface $module_handler) {
    $this->moduleHandler = $module_handler;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('module_handler')
    );
  }

  /**
   * {@inheritdoc}
   */
  protected function getModuleName() {
    return 'directory_callback';
  }

  /**
   * Controlador para ver el directorio de la universidad.
   */
  public function viewDirectory(Request $request) {

    $base_url = $request->getSchemeAndHttpHost();
    $path_module = $this->moduleHandler->getModule('uniagustiniana_directory')->getpath();
    $images = $path_module . '/images/';
    $templates = $path_module . '/js/templates/';
    return [
      '#theme' => 'template-directory',
      '#attached' => [
        'library' => [
          'uniagustiniana_directory/uniagustiniana_directory.js',
        ],
        'drupalSettings' => [
          'uboyaca_directory' => [
            'siteDomain' => $base_url . '/',
            'urlImage' => $base_url . '/' . $images,
            'urlTemplate' => $base_url . '/' . $templates,
          ],
        ],
      ],
    ];
  }

}
