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
 *   id = "programa_nivel_formacion",
 *   label = @Translation("Programa Nivel de formacion"),
 *   description = @Translation("Adds the item's Programa Nivel de formacion to the indexed data."),
 *   stages = {
 *     "add_properties" = 0,
 *   },
 *   locked = true,
 *   hidden = true,
 * )
 */
class ProgramaNivel extends ProcessorPluginBase {

  /**
   * {@inheritdoc}
   */
  public function getPropertyDefinitions(DatasourceInterface $datasource = NULL) {
    $properties = [];

    if (!$datasource) {
      $definition = [
        'label' => $this->t('Programa Nivel de formacion'),
        'description' => $this->t('Programa Nivel de formacion'),
        'type' => 'string',
        'processor_id' => $this->getPluginId(),
      ];
      $properties['search_api_programa_nivel_formacion'] = new ProcessorProperty($definition);
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
    $nivel = $entity->get('field_nivel_de_formacion');
    if(!$nivel){
      return;
        
    }
    $fields = $this->getFieldsHelper()
      ->filterForPropertyPath($item->getFields(), NULL, 'search_api_programa_nivel_formacion');
    foreach ($nivel->referencedEntities() as $niv) {
      foreach ($fields as $field) {
          $field->addValue($niv->getName());
      }
    }
  }
}
