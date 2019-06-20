/**
* OrgChartApp Front-end file
* This file encapsulates all the objects in the app in a window var.
*
*/

( function($,window,document){
  Drupal.behaviors.intranet_org_chart_file1 = {
    attach: function (context, settings) {


			'use-strict';
		
			var siteDomain = drupalSettings.uboyaca_directory.siteDomain;
			var siteImage = drupalSettings.uboyaca_directory.urlImage;
			var siteTemplate = drupalSettings.uboyaca_directory.urlTemplate;
		
			//jQuery('body').once('path-directory', function(){

				var UTOrgChartApp = function(a){

					this.routers = { };
					this.models = { };
					this.collections = { };
					this.views = { };

					this.orgChartTmpPath = siteTemplate;
					this.orgChartImagePath = siteImage;
					this.orgJSONPath = siteDomain + 'directory/json';

				}

				UTOrgChartApp.prototype = {

					initialize: function(){

						// change to true or comment in production
			            EJS.config({cache: true});

					}
				}



				window.OrgChartApp = new UTOrgChartApp();
				window.OrgChartApp.initialize();

			//});
    }
  }
})(jQuery, this, this.document, undefined);

		