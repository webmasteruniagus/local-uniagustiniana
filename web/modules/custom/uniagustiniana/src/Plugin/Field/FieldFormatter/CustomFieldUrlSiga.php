<?php

namespace Drupal\uniagustiniana\Plugin\Field\FieldFormatter;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Field\FormatterBase;
use Drupal\Core\Url;

/**
 * Plugin implementation of the 'commerce_plugin_item_default' formatter.
 *
 * @FieldFormatter(
 *   id = "commerce_plugin_url_siga",
 *   label = @Translation("Url Siga"),
 *   field_types = {
 *     "link"
 *   }
 * )
 */
class CustomFieldUrlSiga extends FormatterBase {

  /**
   * {@inheritdoc}
   */
  public function viewElements(FieldItemListInterface $items, $langcode) {
    $entity = $items->getEntity();
    $activo = $entity->get('field_curso_activo')->getValue();
    if (isset($activo[0]['value']) && $activo[0]['value']) {
      $url = $items->getValue();
      $elements = [
        '#type' => 'link',
        '#title' => $url[0]['title'],
        '#url' => Url::fromUri($url[0]['uri']),
        '#attributes' => [
          'target' => '_blank',
        ],
        '#prefix' => "<div class='field--name-field-enlace-a-siga'>",
        '#suffix' => "</div>",
      ];
    }
    else {
      $elements = [
        '#markup' => "<p class='disabled-course'>Este curso no se encuentra activo en el momento.</p>",
      ];
    }

    return $elements;
  }

}
