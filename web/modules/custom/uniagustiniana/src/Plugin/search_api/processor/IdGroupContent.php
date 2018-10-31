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
 *   id = "id_group_content",
 *   label = @Translation("ID Group"),
 *   description = @Translation("Adds the item's ID Group to the indexed data."),
 *   stages = {
 *     "add_properties" = 0,
 *   },
 *   locked = true,
 *   hidden = true,
 * )
 */
class IdGroupContent extends ProcessorPluginBase {

  /**
   * {@inheritdoc}
   */
  public function getPropertyDefinitions(DatasourceInterface $datasource = NULL) {
    $properties = [];

    if (!$datasource) {
      $definition = [
        'label' => $this->t('ID Group'),
        'description' => $this->t('ID Group'),
        'type' => 'string',
        'processor_id' => $this->getPluginId(),
      ];
      $properties['search_api_id_group'] = new ProcessorProperty($definition);
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
    $query = db_select('node_field_data', 'nfd');
    $query->join('group_content_field_data', 'gcfd', 'nfd.nid = gcfd.entity_id');
    $query->join('groups_field_data', 'gfd', 'gcfd.gid = gfd.id');
    $query->addField('gfd', 'label');
    $query->condition('nfd.type', 'news', '=');
    $query->condition('nfd.nid', $entity->id(), '=');
    $result=$query->execute()->fetchObject();
    if(!$result || !$result->label){
      return;
    }
    $fields = $this->getFieldsHelper()
        ->filterForPropertyPath($item->getFields(), NULL, 'search_api_id_group');
    foreach ($fields as $field) {
      $field->addValue($result->label);
    }
  }

}
