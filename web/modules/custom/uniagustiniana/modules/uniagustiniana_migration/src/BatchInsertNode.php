<?php
/**
 * Created by PhpStorm.
 * User: andres
 * Date: 23/09/18
 * Time: 11:06 PM
 */
namespace Drupal\uniagustiniana_migration;


use Drupal\node\Entity\Node;
use Drupal\group\Entity;
use Drupal\group\Entity\Group;
use Drupal\Core\Database\Database;

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

        switch ($query->catid){
            case 4:
                $group = 7;
                break;
            case 5:
                $group = 8;
                break;
            case 6:
                $group = 9;
                break;
            case 9:
                $group = 10;
                break;
            case 10:
                $group = 11;
                break;
            case 12:
                $group = 12;
                break;
            case 13:
                $group = 13;
                break;
            case 15:
                $group = 14;
                break;
            case 16:
                $group = 15;
                break;
            case 17:
                $group = 16;
                break;
            case 18:
                $group = 17;
                break;
            case 19:
                $group = 18;
                break;
            case 20:
                $group = 19;
                break;
            case 21:
                $group = 20;
                break;
            case 24:
                $group = 21;
                break;
            case 25:
                $group = 22;
                break;
            case 26:
                $group = 23;
                break;
            case 27:
                $group = 24;
                break;
            case 28:
                $group = 25;
                break;
            case 29:
                $group = 26;
                break;
            case 31:
                $group = 27;
                break;
            case 33:
                $group = 28;
                break;
            case 34:
                $group = 29;
                break;
            case 37:
                $group = 2;
                break;
            case 38:
                $group = 5;
                break;
            case 39:
                $group = 6;
                break;
            case 40:
                $group = 30;
                break;
            case 41:
                $group = 31;
                break;
            // case 42:
            //     $group = 56;
            //     break;
            case 43:
                $group = 32;
                break;
            case 45:
                $group = 33;
                break;
            case 46:
                $group = 34;
                break;
            case 47:
                $group = 35;
                break; 
            case 48:
                $group = 36;
                break;
            case 49:
                $group = 37;
                break;
            case 51:
                $group = 3;
                break;
            case 53:
                $group = 38;
                break;
            case 54:
                $group = 39;
                break;
            case 55:
                $group = 57;
                break;
            case 56:
                $group = 40;
                break;
            // case 57:
            //     $group = 41;
            //     break;
            case 59:
                $group = 42;
                break;
            case 61:
                $group = 43;
                break; 
            case 63:
                $group = 44;
                break;
            case 64:
                $group = 45;
                break;
            case 65:
                $group = 46;
                break;
            case 66:
                $group = 47;
                break;
            case 67:
                $group = 48;
                break;
            case 68:
                $group = 49;
                break;
            case 69:
                $group = 50;
                break;
            case 70:
                $group = 51;
                break;
            case 71:
                $group = 52;
                break;
            case 72:
                $group = 53;
                break;
            case 73:
                $group = 54;
                break;
            case 75:
                $group = 46;
                break;
            case 76:
                $group = 55;
                break;
        }

    
        if(isset($group) && is_numeric($group)){
            

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
                $node->set('created', strtotime($query->created));
            }
            if($array_images){
                $folder = format_date(strtotime($query->created), 'custom', 'm-Y');
                $path = 'public://noticias/' . $folder . '/';
                drupal_mkdir($path);
                if (file_prepare_directory($path, FILE_CREATE_DIRECTORY | FILE_MODIFY_PERMISSIONS)) {
                    foreach ($array_images as $key => $image) {
                        
                        switch ($key){
                            case 'absolute':
                                foreach ($image as $key => $img) {
                                    $image_url = basename($img);
                                    $data = file_get_contents($img);
                                    if($data){
                                        $file = file_save_data($data, $path . $image_url, FILE_EXISTS_REPLACE);
                                        $images[] = array(
                                            'target_id' => $file->id(),
                                            'alt' => $query->title
                                        );
                                    }
                                }                           
                            break;
                            case 'relative':
                                foreach ($image as $key => $img) {
                                    $image_url = basename($img);
                                    $data = file_get_contents('public://backup_news/' . $img);
                                    if($data){
                                        $file = file_save_data($data, $path . $image_url, FILE_EXISTS_REPLACE);
                                        $images[] = array(
                                            'target_id' => $file->id(),
                                            'alt' => $query->title
                                        );
                                    }
                                }
                                
                            break;
                        }
                        
                    }
                    if(isset($images)){
                        $node->set('field_news_image', $images);
                    }
                }
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
            if(!$result){
                $group=Group::load($group);
                $group->addContent($node, 'group_node:news');
            }

        }
    }

    public static function InsertNodeEvents($content, &$context){
        Database::setActiveConnection('eventos');
            $query = db_select('wp_posts', 'p');
            $query->addField('p', 'post_date');
            $query->addField('p', 'post_title');
            $query->addField('p', 'post_content');
            $query->innerJoin('wp_postmeta', 'pms', 'p.ID = pms.post_id');
            $query->addField('pms', 'meta_value');
            $query->innerJoin('wp_postmeta', 'pme', 'p.ID = pme.post_id');
            $query->addField('pme', 'meta_value');
            $query->innerJoin('wp_term_relationships', 'tr', 'p.ID = tr.object_id');
            $query->innerJoin('wp_terms', 't', 'tr.term_taxonomy_id = t.term_id');
            $query->addField('t', 'term_id');
            $query->condition('p.ID', $content->ID, '=');
            $query->condition('pms.meta_key', '_EventStartDate', '=');
            $query->condition('pme.meta_key', '_EventEndDate', '=');
            $result = $query->execute()->fetchObject();
        // Switch back
        Database::setActiveConnection();

        switch ($result->term_id) {
            case 85:
                $group = 40;
                break;
            case 82:
                $group = 12;
                break;
            case 94:
                $group = 57;
                break;
            case 95:
                $group = 61;
                break;
            case 109:
                $group = 36;
                break;
            case 86:
                $group = 62;
                break;
            case 93:
                $group = 63;
                break;
            case 110:
                $group = 62;
                break;
            case 108:
                $group = 12;
                break;
            case 104:
                $group = 17;
                break;
            case 101:
                $group = 6;
                break;
            case 83:
                $group = 37;
                break;
            case 89:
                $group = 54;
                break;
            case 112:
                $group = 29;
                break;
            case 100:
                $group = 46;
                break;
            case 114:
                $group = 3;
                break;
            case 87:
                $group = 38;
                break;
            case 113:
                $group = 3;
                break;
            case 91:
                $group = 35;
                break;
            case 96:
                $group = 14;
                break;
            case 105:
                $group = 31;
                break;
            case 107:
                $group = 30;
                break;
            case 106:
                $group = 42;
                break;
            case 84:
                $group = 51;
                break;
        }

        if(isset($group) && is_numeric($group)){

            $gquery = db_select('group_content_field_data', 'gfd');
            $gquery->addField('gfd', 'entity_id');
            $gquery->condition('gfd.gid', $group, '=');
            $gquery->condition('gfd.label', $result->post_title, '=');
            $gresult=$gquery->execute()->fetchObject();

            if($gresult && $gresult->entity_id){
                $node = Node::load($gresult->entity_id);
            }else{
                //Create node object and save it.
                $node = Node::create(['type' => 'event']);
                $node->set('title', $result->post_title);
                $node->set('created', strtotime($result->post_date));
            }

            $text = self::clearHtml($result->post_content, false);
            
            $node->set('body', $text);
            
            $node->body->format = 'full_html';

            $star_date = format_date(strtotime($result->meta_value), 'custom', 'Y-m-d');

            if($star_date){
                $node->set('field_event_start', $star_date);
            }
            
            $end_date = format_date(strtotime($result->pme_meta_value), 'custom', 'Y-m-d');

            if($end_date){
                $node->set('field_event_end', $end_date);
            }

            $star_hour = format_date(strtotime($result->meta_value), 'custom', 'H:i');

            $end_hour = format_date(strtotime($result->pme_meta_value), 'custom', 'H:i');
            
            if($star_hour && $end_hour){
                $node->set('field_event_time', $star_hour . ' - ' . $end_hour);
            }
            
            $array_images = self::getImages($result->post_content);

            if($array_images){
                $folder = format_date(strtotime($result->post_date), 'custom', 'm-Y');
                $path = 'public://eventos/' . $folder . '/';
                if(!is_dir($path)){
                    drupal_mkdir($path, NULL, TRUE);
                }
                foreach ($array_images as $key => $image) {
                    switch ($key){
                        case 'absolute':
                            foreach ($image as $key => $img) {
                                $image_url = basename($img);
                                if(preg_match('/172.16.1.10\b/', $img)){
                                    $replace = str_replace('http://172.16.1.10/eventos/wp-content/uploads/2018/', '', $img);
                                    $data = file_get_contents('public://backup_events/' . $replace);
                                }else{
                                    $data = file_get_contents($img);
                                }                               
                            
                                if($data){
                                    $file = file_save_data($data, $path . $image_url, FILE_EXISTS_REPLACE);
                                    $images[] = array(
                                        'target_id' => $file->id(),
                                        'alt' => $result->post_title
                                    );
                                }
                            } 
                            if(isset($images)){
                                $node->set('field_event_image', $images);
                            }
                            break;
                    }
                }
            }
            $node->save();
            if(!$gresult){
                $group=Group::load($group);
                $group->addContent($node, 'group_node:event');
            }

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

    public function clearHtml($content, $link = true){
        $content = preg_replace("/<img[^>]+\>/i", "(image) ", $content); 
        if($link){
            $content = preg_replace('#<a.*?>(.*?)</a>#i', '$1', $content);
        }
        $content = str_replace('{module Compartir-redes}', '', $content);
        $content = str_replace('(image)', '', $content);
        $content = str_replace('<em>Haz clic sobre la imagen para ampliarla.</em>', '', $content);
        return $content;
    }
}