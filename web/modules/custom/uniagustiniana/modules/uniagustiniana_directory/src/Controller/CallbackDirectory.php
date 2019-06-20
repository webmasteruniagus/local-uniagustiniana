<?php

namespace Drupal\uniagustiniana_directory\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\Request;

/**
 * Controller routines for page example routes.
 */
class CallbackDirectory extends ControllerBase {

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
    $images = \Drupal::moduleHandler()->getModule('uniagustiniana_directory')->getPath() . '/images/';
    $templates = \Drupal::moduleHandler()->getModule('uniagustiniana_directory')->getPath() . '/js/templates/';
    // $this->return = [
    //     '#theme' => 'template-directory',
    //     '#attached' => array(
    //         'library' => array(
    //           'uniagustiniana_directory/uniagustiniana_directory.js',
    //         ),
    //         'drupalSettings' => array(
    //           'uboyaca_directory' => array(
    //               'siteDomain' => $base_url,
    //               'urlImage' => $base_url . $images,
    //               'urlTemplate' => $base_url . $templates
    //           )
    //         )
    //     ),
    // ];
    return [];
  }

}
