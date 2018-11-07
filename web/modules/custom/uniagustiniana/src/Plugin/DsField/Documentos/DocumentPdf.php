<?php

namespace Drupal\uniagustiniana\Plugin\DsField\Documentos;

use Drupal\ds\Plugin\DsField\DsFieldBase;
use Drupal\Core\Url;

/**
 * Plugin that renders the author of a Documentos.
 *
 * @DsField(
 *   id = "document_pdf",
 *   title = @Translation("Documentos PDF"),
 *   entity_type = "documentos",
 *   provider = "eck"
 * )
 */
class DocumentPdf extends DsFieldBase {



	/**
	* {@inheritdoc}
	*/
	public function build() {
		$entity = $this->entity();
		$view_pdf = $entity->get('field_mostrar_pdf')->getValue();
		if(isset($view_pdf[0]['value']) && $view_pdf[0]['value']){
			$files = $entity->get('field_archivo');
			$pdfs = [];
			if($files){
				foreach ($files->referencedEntities() as $key => $file) {
					$pathinfo = pathinfo($file->getFileUri());
					if($pathinfo['extension'] == 'pdf'){
						$pdfs[] = file_create_url($file->getFileUri());
					}
				}
			}
			$return =  [
				'#theme' => 'pdf_documents',
				'#pdfs' => !empty($pdfs)
					? $pdfs
					: FALSE
			];
		}else{
			$return = [];
		}
		return $return;
	}
}
