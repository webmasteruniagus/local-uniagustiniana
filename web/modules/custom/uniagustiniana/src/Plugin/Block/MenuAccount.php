<?php

namespace Drupal\uniagustiniana\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Url;
use Drupal\Core\Link;



/**
 * Provides a 'MenuAccount' Block.
 *
 * @Block(
 *   id = "MenuAccount",
 *   admin_label = @Translation("Menu Account"),
 * )
 */
class MenuAccount extends BlockBase {


  /**
   * {@inheritdoc}
   */

  public function build() {
      if(\Drupal::currentUser()->isAnonymous())
      {
          $item[] = [
              '#markup' => $this->t('<div class="account-register-external">@register_internal</div>',
                  [
                      '@register_internal' => Link::fromTextAndUrl(t('Register'), Url::fromUri('internal:/user/register'))->toString(),
                  ])
          ]; 
          return [
              '#theme' => 'item_list',
              '#list_type' => 'ul',
              '#wrapper_attributes' => [
                  'class' => [
                      'wrapper',
                  ],
              ],
              '#attributes' => [
                  'class' => [
                      'account-register',
                  ],
              ],
              '#items' => $item
          ];
      }else{
          $items[] = [
              '#markup' => Link::fromTextAndUrl(t('Edit User'), Url::fromUri('internal:/user/' . \Drupal::currentUser()->id() . '/edit', array()))->toString(),
              '#wrapper_attributes' => [
                  'class' => [
                      'menu_account_edit',
                  ],
              ]
          ];
          if(in_array('admin_grupo', \Drupal::currentUser()->getRoles()) || in_array('editor', \Drupal::currentUser()->getRoles()) || in_array('redactor', \Drupal::currentUser()->getRoles())){
            $items[] = [
                '#markup' => Link::fromTextAndUrl(t('My contents'), Url::fromUri('internal:/mis-contenidos', array()))->toString(),
                '#wrapper_attributes' => [
                    'class' => [
                        'menu_account_content',
                    ],
                ]
            ];
          }
          $items[] = [
              '#markup' => Link::fromTextAndUrl(t('Logout'), Url::fromUri('internal:/user/logout', array()))->toString(),
              '#wrapper_attributes' => [
                  'class' => [
                      'menu_account_logout',
                  ],
              ]
          ];

          return [
              '#theme' => 'item_list',
              '#list_type' => 'ul',
              '#wrapper_attributes' => [
                  'class' => [
                      'wrapper',
                  ],
              ],
              '#attributes' => [
                  'class' => [
                      'account-register',
                  ],
              ],
              '#items' => [
                  0 => [
                      '#markup' => \Drupal::currentUser()->getAccountName(),
                      '#wrapper_attributes' => [
                          'class' => [
                              'menu_rol_item',
                          ],
                      ],
                      'children' => [
                          '#theme' => 'item_list',
                          '#list_type' => 'ul',
                          '#wrapper_attributes' => [
                              'class' => [
                                  'wrapper',
                              ],
                          ],
                          '#attributes' => [
                              'class' => [
                                  'account-register-items',
                              ],
                          ],
                          '#items' => $items
                      ]
                  ]
              ],
              '#cache' => ['max-age' => 0],
          ];

      }
      return [];
  }
}