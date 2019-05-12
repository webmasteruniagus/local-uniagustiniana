<?php

namespace Drupal\gavias_sliderlayer\Form;

use Drupal\Core\Form\ConfigFormBase;
use Symfony\Component\HttpFoundation\Request;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Datetime\DrupalDateTime;

/**
 * Defines a form that configures forms module settings.
 */
class ConfigurationForm extends ConfigFormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'gavias_sliderlayer_admin_settings';
  }

  /**
   * {@inheritdoc}
   */
  protected function getEditableConfigNames() {
    return [
      'gavias_sliderlayer.settings',
    ];
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state, Request $request = NULL) {

    $config = $this->config('gavias_sliderlayer.settings')->get('config');
    $results = db_select('gavias_sliderlayergroups', 'd')
      ->fields('d', ['id', 'title'])
      ->execute();
    $options = [];
    foreach ($results as $result) {
      $options[$result->id] = $result->title;
    }

    $form['#tree'] = TRUE;

    $form['config'] = [
      '#type' => 'container',
      '#title' => $this->t('Configuración slider'),
    ];

    $form['config']['main_slider'] = [
      '#type' => 'select',
      '#title' => $this->t('Slider principal'),
      '#options' => $options,
      '#default_value' => $config['main_slider'] ?? FALSE,
    ];

    $form['config']['permanent'] = [
      '#type' => 'checkbox',
      '#title' => $this->t('Slider secundario permanente'),
      '#default_value' => $config['permanent'] ?? FALSE,
    ];

    $form['config']['expiration'] = [
      '#type' => 'datetime',
      '#title' => $this->t('Fecha expiracion slider secundario'),
      '#default_value' => $config['expiration'] ? DrupalDateTime::createFromTimestamp($config['expiration']) : FALSE,
    ];

    $form['config']['second_slider'] = [
      '#type' => 'select',
      '#title' => $this->t('Slider secundario'),
      '#options' => $options,
      '#default_value' => $config['second_slider'] ?? FALSE,
    ];

    return parent::buildForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    parent::submitForm($form, $form_state);
    $values = $form_state->getValue('config');
    if (isset($values['expiration'])) {
      $values['expiration'] = $values['expiration']->getTimestamp();
    }
    $this->config('gavias_sliderlayer.settings')
      ->set('config', $values)
      ->save();
  }

}
