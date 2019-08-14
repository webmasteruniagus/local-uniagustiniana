<?php

namespace Drupal\uniagustiniana\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Entity\EntityTypeManagerInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\BinaryFileResponse;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

/**
 * Controller routines for page example routes.
 */
class Download extends ControllerBase {

  /**
   * Variable para trabajar con archivos.
   *
   * @var \Drupal\Core\Entity\EntityTypeManagerInterface
   */
  protected $entityTypeManager;

  /**
   * Constructor del formulario.
   */
  public function __construct(EntityTypeManagerInterface $entity_type_manager) {
    $this->entityTypeManager = $entity_type_manager;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('entity_type.manager')
    );
  }

  /**
   * {@inheritdoc}
   */
  protected function getModuleName() {
    return 'uniagustiniana_download';
  }

  /**
   * Constructs a simple page.s.
   *
   * The router _controller callback, maps the path.
   *
   * _controller callbacks return a renderable array for the content area of the
   * page. The theme system will later render and surround the content with the
   * appropriate blocks, navigation, and styling.
   */
  public function file($fid, Request $request = NULL) {
    $file = $this->entityTypeManager->getStorage('file')->load($fid);
    if ($file) {
      $uri = $file->getFileUri();
      if (file_exists($uri)) {
        $headers = $this->moduleHandler()->invokeAll('file_download', [$uri]);
        foreach ($headers as $result) {
          if ($result == -1) {
            throw new AccessDeniedHttpException();
          }
        }
        if (count($headers)) {
          // \Drupal\Core\EventSubscriber\FinishResponseSubscriber::onRespond()
          // sets response as not cacheable if the Cache-Control header is not
          // already modified. We pass in FALSE for non-private schemes for the
          // $public parameter to make sure we don't change the headers.
          return new BinaryFileResponse($uri, 200, $headers);
        }
        throw new AccessDeniedHttpException();
      }
    }
    throw new NotFoundHttpException();
  }

}
