<?php

namespace Drupal\gavias_sliderlayer\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides blocks which belong to Gavias Slider.
 *
 * @Block(
 *   id = "gavias_sliderlayer_custom_block",
 *   admin_label = @Translation("Gavias SliderLayer Custom"),
 *   category = @Translation("Gavias Slider Custom"),
 * )
 */
class GaviasSliderCustom extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    $config = \Drupal::config('gavias_sliderlayer.settings')->get('config');
    $id = $config['main_slider'] ?? 1;
    if ($config['permanent'] || $config['expiration'] > time()) {
      $id = $config['second_slider'] ?? $id;
    }

    $content_block = gavias_sliderlayer_block_content($id);

    $block = [];
    if ($content_block) {
      $block = [
        '#theme' => 'block-slider',
        '#content' => $content_block,
        '#cache' => ['max-age' => 0],
      ];
    }
    return $block;
  }

}
