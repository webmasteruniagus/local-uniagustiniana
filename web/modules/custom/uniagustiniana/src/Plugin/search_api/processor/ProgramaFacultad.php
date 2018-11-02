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
 *   id = "group_program_facultad",
 *   label = @Translation("Programa - facultad"),
 *   description = @Translation("Adds the item's Programa facultad News to the indexed data."),
 *   stages = {
 *     "add_properties" = 0,
 *   },
 *   locked = true,
 *   hidden = true,
 * )
 */
class ProgramaFacultad extends ProcessorPluginBase {

  /**
   * {@inheritdoc}
   */
  public function getPropertyDefinitions(DatasourceInterface $datasource = NULL) {
    $properties = [];

    if (!$datasource) {
      $definition = [
        'label' => $this->t('Programa facultad'),
        'description' => $this->t('Programa facultad'),
        'type' => 'string',
        'processor_id' => $this->getPluginId(),
      ];
      $properties['search_api_group_program_facultad'] = new ProcessorProperty($definition);
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
    $facultad = $entity->get('field_facultad');
    if(!$facultad){
        return;
    }
    $fields = $this->getFieldsHelper()
      ->filterForPropertyPath($item->getFields(), NULL, 'search_api_group_program_facultad');

    foreach ($facultad->referencedEntities() as $fac) {
      foreach ($fields as $field) {
        $field->addValue($fac->label());
      }
    }
  }
}
