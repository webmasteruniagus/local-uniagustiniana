/*
 |--------------------------------------------------------------------------
 | Tree Nodes Collection
 |--------------------------------------------------------------------------
 |
 | Allows to manage the tree nodes collection
 |
 | @author: Brian Serrano Satizabal.
 | @author-email: deywibkiss@gmail.com
 |
 */
 ( function( $, window, document, utilities ){

 	Drupal.behaviors.intranet_org_chart_file3 = {
	    attach: function (context, settings) {

	 	'use-strict';

	 	//jQuery('body').once('path-directory', function(){


		 	treeNodes = Backbone.Collection.extend({

		 			urlRoot: "treenodes"

		 		,	model: treenode

		 		,	initialize: function( models ){

		 				// Bind collection events
		                // this.on( 'sync change remove reset', function(){	
		                // 	window.App.views.sailings.renderItems();
		                // });

		 			}

		 			/**
		 			* Resets the collection with an array of
		 			* objects transforming them into
		 			* models then render collection
		 			* in the view
		 			*
		 			* @param { objects }
		 			* @param { function } a callback function called after reset
		 			*/
		 		,	parse: function( objects, callback ){

		 				var models = [];

		                $.each( objects, function( key, value ){

		                    var model = new treenode( value );

		                    models.push( model );
		                });

		                this.reset( models );

		                if( typeof callback === 'function' )
		                	callback.call();
		 			}

		 			/**
		 			* Gets the children of a model by id and level
		 			*
		 			* @param { numeric } the id of the parent model
		 			* @param { integer } the level of the children, if it is not passed
		 			*					 the function returns all the children
		 			*
		 			* @return { array } list of the childrens filtered
		 			*
		 			*/
		 		,	getChildren: function( params ){

		 				// Filter the collection
		 				var newCollection = this.clone();


					    _.each(params, function(val, key){

					        if (typeof val !== 'object') val = [ val ];

					        newCollection.models = _.filter(newCollection.models, function(model){
					            return _.indexOf(val, model.get(key)) !== -1;
					        }, this);
					    }, this);



					    newCollection.reset(newCollection.models);

					    return newCollection;


		 			}

		 			/**
		 			* Get items from parent or not where not in the levels given
		 			*
		 			* @param { array } the array of levels
		 			*
		 			*/
		 		,	notInLevel: function( levels ){

		 				var items = this.clone();


				        items.models = _.filter(items.models, function(model){
				            
				            return $.inArray( model.get('nivel'), levels ) === -1;

				        }, items);

					    return items.reset(items.models);
		 			}


		 			/**
		 			* Search the items by any attribute
		 			*
		 			* @param { array } the array of key-value pairs to search in
		 			* @return { collection } the items that match to
		 			*
		 			*/
		 		,	search : function(params){

		 				// Filter the collection
		 				var newCollection = this.clone();

		 				var _models = [];
		 		 

		 				_.each(params, function(val, key){

		 				    if (typeof val !== 'object') val = [ val ];

		 				    for (var _key in val) {

		 				    	var newKey = val[_key].replace(/\s/g, '.*');
			 					
			 					var pattern = new RegExp(newKey,"gi");

			 				    col_models = _.filter(newCollection.models, function(model){
			 				        return pattern.test(model.get(_key));
			 				    }, this);

			 				    if(newCollection.models.length > 0)
			 				    	$.merge( _models, col_models);
		 				    }
		 					
		 				}, this);

		 				newCollection.reset(_models);

		 				return newCollection;
		 			}

		 	});
		//});
		
		}
	}


 })(jQuery, this, this.document, this.Misc, undefined);
//# sourceMappingURL=collections.js.map
