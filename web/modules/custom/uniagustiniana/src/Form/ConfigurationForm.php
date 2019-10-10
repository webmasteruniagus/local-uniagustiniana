<?php

namespace Drupal\uniagustiniana\Form;

use Drupal\Core\Form\ConfigFormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Defines a form that configures forms module settings.
 */
class ConfigurationForm extends ConfigFormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'uniagustiniana_settings';
  }

  /**
   * {@inheritdoc}
   */
  protected function getEditableConfigNames() {
    return [
      'uniagustiniana.settings',
    ];
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    $form['#tree'] = TRUE;
    $config = $this->config('uniagustiniana.settings');

    $basic = $config->get('basic');

    $form['basic'] = [
      '#type' => 'details',
      '#title' => $this->t('Configuraciones generales'),
      '#group' => 'bootstrap',
    ];

    $form['basic']['label_program'] = [
      '#type' => 'textfield',
      '#title' => 'Label programas',
      '#default_value' => $basic['label_program'] ?? FALSE,
    ];

    return parent::buildForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    parent::submitForm($form, $form_state);
    $this->config('uniagustiniana.settings')
      ->set('basic', $form_state->getValue('basic'))
      ->save();
  }

}
