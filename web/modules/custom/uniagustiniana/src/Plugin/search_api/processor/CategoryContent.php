<?php

namespace Drupal\uniagustiniana\Plugin\search_api\processor;

use Drupal\search_api\Datasource\DatasourceInterface;
use Drupal\search_api\Item\ItemInterface;
use Drupal\search_api\Processor\ProcessorPluginBase;
use Drupal\search_api\Processor\ProcessorProperty;

/**
 * Adds the item's URL to the indexed data.
 *
 * @SearchApiProcessor(
 *   id = "category_content_news",
 *   label = @Translation("Category Content News"),
 *   description = @Translation("Adds the item's Category Content News to the indexed data."),
 *   stages = {
 *     "add_properties" = 0,
 *   },
 *   locked = true,
 *   hidden = true,
 * )
 */
class CategoryContent extends ProcessorPluginBase {

  /**
   * {@inheritdoc}
   */
  public function getPropertyDefinitions(DatasourceInterface $datasource = NULL) {
    $properties = [];

    if (!$datasource) {
      $definition = [
        'label' => $this->t('Category Content'),
        'description' => $this->t('Category Content'),
        'type' => 'string',
        'processor_id' => $this->getPluginId(),
      ];
      $properties['search_api_category_content_news'] = new ProcessorProperty($definition);
    }

    return $properties;
  }

  /**
   * {@inheritdoc}
   */
  public function addFieldValues(ItemInterface $item) {
    $entity = $item->getOriginalObject()->getValue();

    if(!$entity){
      return;
    }
    $categories = $entity->get('field_category');
    if(!$categories){
      return;
        
    }
    $fields = $this->getFieldsHelper()
    ->filterForPropertyPath($item->getFields(), NULL, 'search_api_category_content_news');
    foreach ($categories->referencedEntities() as $category) {
      foreach ($fields as $field) {
          $field->addValue($category->getName());
      }
    }
  }
}
