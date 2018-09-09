<?php

namespace Drupal\uniagustiniana\Controller;

use Drupal\Core\Controller\ControllerBase;

/**
 * Controller routines for page example routes.
 */
class Home extends ControllerBase {

  /**
   * {@inheritdoc}
   */
  protected function getModuleName() {
    return 'uniagustiniana_home';
  }


  /**
   * Constructs a simple page.s
   *
   * The router _controller callback, maps the path
   *
   * _controller callbacks return a renderable array for the content area of the
   * page. The theme system will later render and surround the content with the
   * appropriate blocks, navigation, and styling.
   */
  public function View($tid) {
    return [
      '#markup' => ''
    ];
  }
}
