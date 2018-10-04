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

        // ksm($text1);
        // ksm($text2);

        // $node = Node::create(['type' => 'inmueble']);
        // $node->set('title', $content['titulo']);
        //ksm($array_images);
        

        $group = 2;
        


        if($group){

            $query = db_select('group_content_field_data', 'gfd');
            $query->addField('gfd', 'entity_id');
            $query->condition('gfd.gid', $group, '=');
            $query->condition('gfd.label', $query->title, '=');
            $result=$query->execute()->fetchObject();
            if($result && $result->entity_id){
                $node = Node::load($result->entity_id);
            }else{
                // Create node object and save it.
                // $node = Node::create(['type' => 'inmueble']);
                // $node->set('title', $content['titulo']);

                if($array_images){
                    $images = [];
                    foreach ($array_images as $key => $image) {
                        //ksm($key);
                        switch ($key){
                            case 'absolute':
                                //$file = system_retrieve_file($image, 'public://noticias', TRUE, FILE_EXISTS_REPLACE);
                                $data = file_get_contents($image[0]);
                                ksm($data);
                            break;
                            case 'relative':
                                //$path = drupal_realpath('public://' . $image[0]);
                                //ksm($path);
                                $data = file_get_contents('public://' . $image[0]);
                                ksm($data);
                            break;
                        }
                        //ksm($image);
                        
                        // $file = file_save_data($data, "public://" . $image_url, FILE_EXISTS_RENAME);
                        // $images[] = array(
                        //     'target_id' => $file->id(),
                        //     'alt' => $content['titulo']
                        // );
             
                     }
                        
                    
                    //$node->set('field_property_image', $images);
                }
            }
        }

        //     if($content['codigo']){
        //         $node->set('field_codigo_inmueble', $content['codigo']);
        //     }
        //     if($content['imagen']){
        //         $images_url = explode(',', $content['imagen']);
        //         $images = [];
        //         foreach ($images_url as $image_url){
        //             //Save Image in local from remote data.
        //             $data = file_get_contents(file_directory_temp() . '/' . $_SESSION['folder']. '/' . $image_url);
        //             $file = file_save_data($data, "public://" . $image_url, FILE_EXISTS_RENAME);
        //             $images[] = array(
        //                 'target_id' => $file->id(),
        //                 'alt' => $content['titulo']
        //             );
        //         }
        //         $node->set('field_property_image', $images);
        //     }
        //     if($content['tipo_operacion']){
        //         $node->set('field_choose_operation_type', $content['tipo_operacion']);
        //     }
        //     if($content['ciudad']){
        //         $node->set('field_city', $content['ciudad']);
        //     }
        //     if($content['zona']){
        //         $node->set('field_barrio_zona', $content['zona']);
        //     }
        //     if($content['precio']){
        //         $precio = trim($content['precio']);
        //         if(is_numeric($precio)){
        //             $node->set('field_precio_float', $precio);
        //         }
        //     }
        //     if($content['administracion']){
        //         $node->set('field_incluied_administration', $content['administracion']);
        //         if($content['precio_administracion']){
        //             $precio_administracion = trim($content['precio_administracion']);
        //             if(is_numeric($precio_administracion)){
        //                 $node->set('field_property_admin_price', $precio_administracion);
        //             }
        //         }
        //     }
        //     if($content['direccion']){
        //         $field_collection_item = FieldCollectionItem::create([
        //             'field_name' => 'field_property_location'
        //         ]);


        //         $node->field_property_location->appendItem($field_collection_item);

        //         $field_collection_item->field_property_location_address->value = $content['direccion'];

        //         if($content['coordenadas']){
        //             $coordenada = explode(',', $content['coordenadas']);
        //             $lat = $coordenada[0];
        //             $lng = $coordenada[1];
        //             $edit = array(
        //                 'lat' => $lat,
        //                 'lng' => $lng,
        //             );
        //             $field_collection_item->set('field_property_location_in_map', $edit);
        //         }
        //     }

        //     if($content['inmueble_nuevo']){
        //         $node->set('field_property_is_new', $content['inmueble_nuevo']);
        //     }
        //     if($content['inmueble_disponible']){
        //         $node->set('field_state_property', $content['inmueble_disponible']);
        //     }
        //     if($content['piso']){
        //         $node->set('field_property_level_floor', trim($content['piso']));
        //     }
        //     if($content['antiguedad']){
        //         $node->set('field_property_rank_antiquity', $content['antiguedad']);
        //     }
        //     $field_collection_item2 = FieldCollectionItem::create([
        //         'field_name' => 'field_about_property'
        //     ]);
        //     $node->field_about_property->appendItem($field_collection_item2);
        //     if($content['area']){
        //         $field_collection_item2->field_area->value = trim($content['area']);
        //     }
        //     if($content['banos']){
        //         $field_collection_item2->field_property_bathrooms->value = trim($content['banos']);
        //     }
        //     if($content['habitaciones']){
        //         $field_collection_item2->field_property_rooms->value = trim($content['habitaciones']);
        //     }
        //     if($content['estrato']){
        //         $field_collection_item2->field_property_stratum->value = trim($content['estrato']);
        //     }
        //     if($content['tipo_inmueble']){
        //         $node->set('field_tipo_de_inmueble', $content['tipo_inmueble']);
        //     }
        //     if($content['descripcion']){
        //         $node->set('field_property_descrip', $content['descripcion']);
        //     }
        //     if($content['caracteristicas_sector']){
        //         $carsector = explode(';', $content['caracteristicas_sector']);
        //         $tid_csec = [];
        //         foreach ($carsector as $csec){
        //             $term = \Drupal::entityTypeManager()
        //                 ->getStorage('taxonomy_term')
        //                 ->loadByProperties(['name' => $csec]);
        //             if($term){
        //                 $term = reset($term);
        //                 $tid_csec[] = $term->id();
        //             }
        //         }
        //         $node->set('field_caracteristicas_del_sector', $tid_csec);
        //     }
        //     if($content['caracteristicas_exteriores']){
        //         $carext = explode(';', $content['caracteristicas_exteriores']);
        //         $tid_ext = [];
        //         foreach ($carext as $cext){
        //             $term = \Drupal::entityTypeManager()
        //                 ->getStorage('taxonomy_term')
        //                 ->loadByProperties(['name' => $cext]);
        //             if($term){
        //                 $term = reset($term);
        //                 $tid_ext[] = $term->id();
        //             }
        //         }
        //         $node->set('field_caracteristicas_exteriores', $tid_ext);
        //     }
        //     if($content['caracteristicas_interior']){
        //         $carint = explode(';', $content['caracteristicas_interior']);
        //         $tid_int = [];
        //         foreach ($carint as $cint){
        //             $term = \Drupal::entityTypeManager()
        //                 ->getStorage('taxonomy_term')
        //                 ->loadByProperties(['name' => $cint]);
        //             if($term){
        //                 $term = reset($term);
        //                 $tid_int[] = $term->id();
        //             }
        //         }
        //         $node->set('field_caracteristicas_interior', $tid_int);
        //     }
        //     $node->save();
        //     if(!$result){
        //         $group=Group::load($content['group']);
        //         $group->addContent($node, 'group_node:inmueble');
        //     }

        //     $message = 'Insert Node...';
        // }else{
        //     $message = "no fue posible insertar el contenido";
        // }
        // $context['message'] = $message;
        // $context['results'][] = 1;
    }
    
    function InsertNodeInmuebleFinishedCallback($success, $results, $operations) {
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
        return $content;
    }
}