<?php

namespace Drupal\uniagustiniana\Plugin\Block;

use Drupal\Core\Block\BlockBase;


/**
 * Provides a 'SerchProgramBlock' Block.
 *
 * @Block(
 *   id = "SerchProgramBlock",
 *   admin_label = @Translation("Find the program of your interest"),
 * )
 */
class SearchProgramBlock extends BlockBase {


    /**
     * {@inheritdoc}
     */

    public function build() {

        $form = \Drupal::formBuilder()->getForm('Drupal\uniagustiniana\Form\SearchProgram');

        return $form;
    }
}