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
            case 42:
                $group = 56;
                break;
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
            case 57:
                $group = 41;
                break;
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
                    $images = [];
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
                    $node->set('field_news_image', $images);
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

        }else{
            ksm($query);
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
        $content = preg_replace('#<a.*?>(.*?)</a>#i', '', $content);
        $content = str_replace('{module Compartir-redes}', '', $content);
        $content = str_replace('(image)', '', $content);
        $content = str_replace('<em>Haz clic sobre la imagen para ampliarla.</em>', '', $content);
        return $content;
    }
}