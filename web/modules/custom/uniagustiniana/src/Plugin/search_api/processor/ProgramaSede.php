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
 *   id = "programa_sede",
 *   label = @Translation("Programa sede"),
 *   description = @Translation("Adds the item's Programa sede to the indexed data."),
 *   stages = {
 *     "add_properties" = 0,
 *   },
 *   locked = true,
 *   hidden = true,
 * )
 */
class ProgramaSede extends ProcessorPluginBase {

  /**
   * {@inheritdoc}
   */
  public function getPropertyDefinitions(DatasourceInterface $datasource = NULL) {
    $properties = [];

    if (!$datasource) {
      $definition = [
        'label' => $this->t('Programa Sede'),
        'description' => $this->t('Programa Sede'),
        'type' => 'string',
        'processor_id' => $this->getPluginId(),
      ];
      $properties['search_api_programa_sede'] = new ProcessorProperty($definition);
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
    $sedes = $entity->get('field_sede');
    if(!$sedes){
      return;
        
    }
    $fields = $this->getFieldsHelper()
      ->filterForPropertyPath($item->getFields(), NULL, 'search_api_programa_sede');
    foreach ($sedes->referencedEntities() as $sede) {
      foreach ($fields as $field) {
          $field->addValue($sede->getName());
      }
    }
  }
}
