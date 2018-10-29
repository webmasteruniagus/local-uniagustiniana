<?php

namespace Drupal\uniagustiniana_migration\Form;


use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class MigrationNews.
 *
 * @package Drupal\uniagustiniana_migration\Form
 */
class MigrationNews extends FormBase {
    /**
     * {@inheritdoc}
     */
    public function getFormId() {
        return 'migrations_news';
    }
    /**
     * {@inheritdoc}
     */
    public function buildForm(array $form, FormStateInterface $form_state) {
        
        $form['insert_node'] = array(
            '#type' => 'submit',
            '#value' => $this->t('Insertar noticias'),
        );
        return $form;
    }
    /**
     * {@inheritdoc}
     */
    public function submitForm(array &$form, FormStateInterface $form_state) {
        \Drupal\Core\Database\Database::setActiveConnection('slave');
            $query = db_select('rl2tw_k2_items', 'nw');
            $query->addField('nw', 'id');
            $db_or = db_or();
            $db_or->condition('nw.created_by', 47, '=');
            $db_or->condition('nw.created_by', 42, '=');
            $db_or->condition('nw.created_by', 49, '=');
            $db_or->condition('nw.created_by', 51, '=');
            $db_or->condition('nw.created_by', 58, '=');
            $db_or->condition('nw.created_by', 59, '=');
            $query->condition($db_or);
            $query->condition('nw.created_by_alias', 'Super User', '<>');
            $query->condition('nw.introtext', '%'.db_like('Lorem').'%', 'NOT LIKE');
            $query->condition('nw.fulltext', '%'.db_like('Lorem').'%', 'NOT LIKE');
            $query->condition('nw.introtext', '%'.db_like('ipsum').'%', 'NOT LIKE');
            $query->condition('nw.fulltext', '%'.db_like('ipsum').'%', 'NOT LIKE');
            $query->condition('nw.title', '%'.db_like('Joomla').'%', 'NOT LIKE');
            $query->condition('nw.created', '%'.db_like('00:00:00').'%', 'NOT LIKE');
            $query->condition('nw.title', '%'.db_like('JA').'%', 'NOT LIKE');
            $query->condition('nw.title', '%'.db_like('etets').'%', 'NOT LIKE');
            //$query->range(0, 50);
            $results = $query->execute()->fetchAll();
        // Switch back
        \Drupal\Core\Database\Database::setActiveConnection();
        $limit = 1;
        $chunks_data = array_chunk($results, $limit);
        foreach ($chunks_data as $chunk_data) {
            $operations[] = array('\Drupal\uniagustiniana_migration\BatchInsertNode::InsertNodeNews', $chunk_data);
        }
        $batch = array(
            'title' => t('Insert News... '),
            'operations' => $operations,
            'finished' => '\Drupal\uniagustiniana_migration\BatchInsertNode::InsertNodeFinishedCallback',
        );
        batch_set($batch);  
    }
}