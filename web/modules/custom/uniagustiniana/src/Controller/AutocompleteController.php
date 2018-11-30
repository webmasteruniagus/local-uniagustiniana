<?php

namespace Drupal\uniagustiniana\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Drupal\Component\Utility\Tags;
use Drupal\Component\Utility\Unicode;

/**
 * Defines a route controller for entity autocomplete form elements.
 */
class AutocompleteController extends ControllerBase {

    /**
     * Handler for autocomplete request.
     * @param string $request se enviaron paramentros consultar
     * @return json Valores encontrados en la consulta formato json
     */
    public function handleAutocomplete(Request $request) {
        $matches = array();
        $string = $request->query->get('q');
        if ($string) {
            $matches = array();
            $query = db_select('groups', 'g');
            $query->addField('g', 'id');
            $query->join('groups_field_data', 'gfd', 'g.id = gfd.id');
            $query->addField('gfd', 'label');
            $query->condition('g.type', 'programa', '=');
            $query->condition('gfd.label', '%'.db_like($string).'%', 'LIKE');
            $result=$query->execute();
            foreach ($result as $row) {
                $matches[] = ['value' => $row->label, 'label' => $row->label];
            }
        }
        return new JsonResponse($matches);
    }

}