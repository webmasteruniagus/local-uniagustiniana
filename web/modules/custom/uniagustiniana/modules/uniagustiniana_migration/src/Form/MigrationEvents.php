<?php

namespace Drupal\uniagustiniana_migration\Form;


use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class MigrationEvents.
 *
 * @package Drupal\uniagustiniana_migration\Form
 * 
 */
class MigrationEvents extends FormBase {
    /**
     * {@inheritdoc}
     */
    public function getFormId() {
        return 'migrations_events';
    }

    /**
     * Formulario ejecucion batch migracion eventos
     *
     * @param array $form
     * @param FormStateInterface $form_state
     * @return object
     */
    public function buildForm(array $form, FormStateInterface $form_state) {
        
        $form['insert_node'] = array(
            '#type' => 'submit',
            '#value' => $this->t('Insertar eventos'),
        );
        return $form;
    }
    /**
     * {@inheritdoc}
     */
    public function submitForm(array &$form, FormStateInterface $form_state) {
        \Drupal\Core\Database\Database::setActiveConnection('eventos');
            $query = db_select('wp_posts', 'p');
            $query->addField('p', 'ID');
            $query->innerJoin('wp_term_relationships', 'tr', 'p.ID = tr.object_id');
            $query->innerJoin('wp_terms', 't', 'tr.term_taxonomy_id = t.term_id');
            $query->condition('p.post_status', 'publish', '=');
            $query->condition('p.post_content', '', '!=');
            $results = $query->execute()->fetchAll();
        // Switch back
        \Drupal\Core\Database\Database::setActiveConnection();

        $limit = 1;
        $chunks_data = array_chunk($results, $limit);
        foreach ($chunks_data as $chunk_data) {
            $operations[] = array('\Drupal\uniagustiniana_migration\BatchInsertNode::InsertNodeEvents', $chunk_data);
        }
        $batch = array(
            'title' => t('Insert News... '),
            'operations' => $operations,
            'finished' => '\Drupal\uniagustiniana_migration\BatchInsertNode::InsertNodeFinishedCallback',
        );
        batch_set($batch);  
    }
}