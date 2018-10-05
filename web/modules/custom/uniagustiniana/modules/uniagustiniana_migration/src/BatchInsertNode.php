<?php
/**
 * Created by PhpStorm.
 * User: andres
 * Date: 23/09/18
 * Time: 11:06 PM
 */
namespace Drupal\uniagustiniana_migration;


use Drupal\node\Entity\Node;
use Drupal\group\Entity\Group;

class BatchInsertNode {
    
    public static function InsertNodeNews($content, &$context){
        \Drupal\Core\Database\Database::setActiveConnection('slave');
            $query = db_query("SELECT * FROM rl2tw_k2_items it
            where it.id = :id", ['id' => $content->id])->fetchObject();
            
        \Drupal\Core\Database\Database::setActiveConnection();
        
        if(!empty($query->introtext)){

            $text1 = self::clearHtml($query->introtext);
            $array_images = self::getImages($query->introtext);

        }

        if(!empty($query->fulltext)){
            $img = isset($array_images) 
                ? $array_images
                : [];
            $array_images = self::getImages($query->fulltext, $img);
            $text2 = self::clearHtml($query->fulltext);
        }


        $group = 2;
        


        if($group){
            

            $gquery = db_select('group_content_field_data', 'gfd');
            $gquery->addField('gfd', 'entity_id');
            $gquery->condition('gfd.gid', $group, '=');
            $gquery->condition('gfd.label', $query->title, '=');
            $result=$gquery->execute()->fetchObject();

            if($result && $result->entity_id){
                $node = Node::load($result->entity_id);
            }else{
                //Create node object and save it.
                $node = Node::create(['type' => 'news']);
                $node->set('title', $query->title);
            }
            if($array_images){
                $images = [];
                foreach ($array_images as $key => $image) {
                    $image_url = basename($image[0]);
                    switch ($key){
                        case 'absolute':
                            $data = file_get_contents($image[0]);
                        break;
                        case 'relative':
                            $data = file_get_contents('public://' . $image[0]);
                        break;
                    }
                    if($data){
                        $file = file_save_data($data, "public://noticias/" . $image_url, FILE_EXISTS_RENAME);
                        $images[] = array(
                            'target_id' => $file->id(),
                            'alt' => $query->title
                        );
                    }
                }
                    
                $node->set('field_news_image', $images);
            }

            if($text1 && $text2){
                $node->set('body', $text1 . '</br>' . $text2);
            }elseif($text1){
                $node->set('body', $text1);
            }elseif($text2){
                $node->set('body', $text2);
            }

            $node->body->format = 'full_html';

            $node->save();
            // if(!$result){
            //     $group=Group::load($group);
            //     $group->addContent($node, 'group_node:' . $group->getGroupType()->id());
            // }

        }
    }
    
    function InsertNodeFinishedCallback($success, $results, $operations) {
        // The 'success' parameter means no fatal PHP errors were detected. All
        // other error management should be handled using 'results'.
        if ($success) {
            $message = \Drupal::translation()->formatPlural(
                count($results),
                'One post processed.', '@count posts processed.'
            );
        }
        else {
            $message = t('Finished with an error.');
        }
        drupal_set_message($message);
    }

    public function getImages($string, $array = []){
        preg_match_all( '@src="([^"]+)"@' , $string, $match );
        $src = array_pop($match);
        $resultado = array_merge($src, $array);

        $return = FALSE;
        if(!empty($resultado)){
            foreach ($resultado as $value) {
                $allowed =  array('png' ,'jpg', 'jpeg');
                $ext = pathinfo($value, PATHINFO_EXTENSION);
                if(in_array($ext,$allowed) ) {
                    $path = parse_url($value);
                    if(isset($path['scheme'])){
                        $return['absolute'][] = $value;
                    }else
                    {
                        $return['relative'][] = $value;
                    }
                }
            }
        }
        return $return;
    }

    public function clearHtml($content){
        $content = preg_replace("/<img[^>]+\>/i", "(image) ", $content); 
        $content = str_replace('{module Compartir-redes}', '', $content);
        $content = str_replace('(image)', '', $content);
        $content = str_replace('<em>Haz clic sobre la imagen para ampliarla.</em>', '', $content);
        return $content;
    }
}