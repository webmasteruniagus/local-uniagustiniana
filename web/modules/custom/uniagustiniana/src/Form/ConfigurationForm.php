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

    $siga = $config->get('siga');

    $form['siga'] = [
      '#type' => 'details',
      '#title' => $this->t('Configuraciones siga'),
      '#group' => 'bootstrap',
    ];

    $form['siga']['url'] = [
      '#type' => 'textfield',
      '#title' => 'Endpoint',
      '#default_value' => $siga['url'] ?? FALSE,
      '#required' => TRUE,
    ];

    $form['siga']['client_id'] = [
      '#type' => 'textfield',
      '#title' => 'Client Id',
      '#default_value' => $siga['client_id'] ?? FALSE,
      '#required' => TRUE,
    ];

    $form['siga']['secret'] = [
      '#type' => 'textfield',
      '#title' => 'Secret',
      '#default_value' => $siga['secret'] ?? FALSE,
      '#required' => TRUE,
    ];

    $form['siga']['usuario'] = [
      '#type' => 'textfield',
      '#title' => 'Usuario',
      '#default_value' => $siga['usuario'] ?? FALSE,
      '#required' => TRUE,
    ];

    $form['siga']['clave'] = [
      '#type' => 'password',
      '#title' => 'Clave',
      '#attributes' => [
        'value' => [$siga['clave'] ?? FALSE],
        '#required' => TRUE,
      ],
    ];

    $form['siga']['email'] = [
      '#type' => 'email',
      '#title' => 'Correos',
      '#default_value' => $siga['email'] ?? FALSE,
      '#description' => $this->t('Si desea mas de un correo separarlos por ,'),
      '#required' => TRUE,
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
      ->set('siga', $form_state->getValue('siga'))
      ->save();
  }

}
