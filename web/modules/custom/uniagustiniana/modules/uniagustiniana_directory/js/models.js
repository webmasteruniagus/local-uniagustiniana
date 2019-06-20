/*
 |--------------------------------------------------------------------------
 |  Model for Tree Node
 |--------------------------------------------------------------------------
 |
 | Allows to manage the tree node model
 |
 | @author: Brian Serrano Satizabal.
 | @author-email: deywibkiss@gmail.com
 |
 */
 ( function( $, window, document ){
 	Drupal.behaviors.intranet_org_chart_file2 = {
	    attach: function (context, settings) {

	    	//jQuery('body').once('path-directory', function(){
			 	treenode = Backbone.Model.extend({

			 			urlRoot: "treenode"

			 		,	idAttribute: "id"

			 		,	defaults: {
			 				id: null,
							nivel: 0,
							nombre: "",
							cargo: "",
							area: "",
							dependencia: null,
							fotografia: "",
							ciudad: "",
							extension: "",
							correo: "",
							direccion: "",
							telefono: "",
							codigo: "",
              ubicacion: ""
			 			}

			 		,	required: []

			 		,	errors: []

			 		,	initialize: function(){ }

			 		,	validate: function( attrs, options ){ }

			 		,	onInvalid: function( model, error ){

			 				return error;

			 			}

			 	});
			//});

		}
	}


 })(jQuery, this, this.document, undefined);
//# sourceMappingURL=models.js.map
