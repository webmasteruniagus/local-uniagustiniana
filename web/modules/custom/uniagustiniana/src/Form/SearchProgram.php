<?php
/**
 * @file
 * Contains \Drupal\uniagustiniana\Form\WorkForm.
 */
namespace Drupal\uniagustiniana\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Url;
use Drupal\Core\Ajax\AjaxResponse;
use Drupal\Core\Ajax\RedirectCommand;

class SearchProgram extends FormBase {
    /**
     * {@inheritdoc}
     */
    public function getFormId() {
        return 'search_program';
    }
    /**
     * @brief Formulario de busqueda de programas.
     * {@inheritdoc}
     * @param object $form valores por default formulario
     * @param object $form_state valores por cambios en el formulario.
     * @return object retorna formulario
     */
    public function buildForm(array $form, FormStateInterface $form_state) {
        
        $form['header'] = array(
            '#markup' => $this->t('<h3><strong>Encuentra el programa</strong> de tu interés</h3>'),
        );
        $form['search'] = array(
            '#type' => 'textfield',
            '#attributes' => [
                'placeholder' => t('Ej: Mecatrónica')
            ],
            '#autocomplete_route_name' => 'uniagustiniana.program_autocomplete',
        );
        $form['actions']['submit'] = array(
            '#type' => 'submit',
            '#value' => $this->t('Search'),
            // '#ajax' => [
            //     'callback' => '::ajaxSubmitForm',
            //     'wrapper' => 'message-wrapper-program',
            // ],
            '#button_type' => 'primary',
        );
        $form['messages'] = [
            '#type' => 'container',
            '#attributes' => ['id' => 'message-wrapper-program'],
        ];
        return $form;
    }
    /**
     * {@inheritdoc}
     */
    public function submitForm(array &$form, FormStateInterface $form_state) {
        $search = $form_state->getValue('search');

        $query = db_select('groups', 'g');
        $query->addField('g', 'id');
        $query->join('groups_field_data', 'gfd', 'g.id = gfd.id');
        $query->condition('g.type', 'programa', '=');
        $query->condition('gfd.label', '%'.db_like($search).'%', 'LIKE');
        $result=$query->execute()->fetchObject();
        if($result && $result->id){
            $form_state->setRedirect(
                'entity.group.canonical',
                [
                'group' => $result->id
                ]
            );
        }
    }

    // public function ajaxSubmitForm(array &$form, FormStateInterface $form_state) {
    //     $search = $form_state->getValue('search');

    //     $query = db_select('groups', 'g');
    //     $query->addField('g', 'id');
    //     $query->join('groups_field_data', 'gfd', 'g.id = gfd.id');
    //     $query->condition('g.type', 'programa', '=');
    //     $query->condition('gfd.label', '%'.db_like($search).'%', 'LIKE');
    //     $result=$query->execute()->fetchObject();
    //     if($result && $result->id){
    //         $response = new AjaxResponse();
    //         $alias = \Drupal::service('path.alias_manager')->getAliasByPath('/group/' . $result->id);
    //         $redirect = new RedirectCommand($alias);
    //         $response->addCommand($redirect);
    //         return $response;
    //     }else{
    //         $form['messages']['label'] = array(
    //             '#type' => 'item',
    //             '#markup' => $this->t('No results found'),
    //         );
    //         return $form['messages'];
    //     }
    // }
}