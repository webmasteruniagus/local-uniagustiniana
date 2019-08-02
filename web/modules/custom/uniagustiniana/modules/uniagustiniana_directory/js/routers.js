/**
 * Main router for app
 * Manages the url routers and triggers some functions
 *
 * @author: Brian Serano Satizabal
 * @author-email: deywibkiss@gmail.com
 * @app-version: 0.0.1
 *
 */
( function( $, window, document ){

    Drupal.behaviors.intranet_org_chart_file4 = {
        attach: function (context, settings) {

            'use-strict';

            //jQuery('body').once('path-directory', function(){
            var OrgChartRouter = Backbone.Router.extend({

                /**
                 * Define the user routes
                 *
                 */
                routes: {
                    "org": "main",
                    "org/:id": "subchart",
                    "search": "searchPage",
                    "org/search/:term/:page": "search"
                }

                ,   initialize: function(){

                }


                /**
                 * This route call an ajax api url
                 * and then get a json string
                 * Collection is init with the objects
                 *
                 */
                ,   main: function(){

                    // Fetch the data from https://api.myjson.com/bins/2gr36
                    $.getJSON( window.OrgChartApp.orgJSONPath, function(data){

                        // Transform into collection
                        window.OrgChartApp.views.orgchart.nodes.parse(data, function(){
                            // Call the view and render the main org chart page
                            window.OrgChartApp.views.orgchart.renderMain();
                        });

                        $('.progress-loader-icon').hide();

                    }).fail( function(){
                        console.log( 'error!' );
                        $('.progress-loader-icon').hide();
                    });

                }

                /**
                 * Call the view function to render the
                 * org chart from item by id
                 *
                 */
                ,   subchart: function( id ){

                    // Fetch data again, if collection is empty
                    if( window.OrgChartApp.views.orgchart.nodes.length == 0 )
                    // Fetch the data from https://api.myjson.com/bins/2gr36
                        $.getJSON( window.OrgChartApp.orgJSONPath, function(data){

                            // Transform into collection
                            window.OrgChartApp.views.orgchart.nodes.parse( data, function(){
                                // Call the view and render the main org chart page
                                window.OrgChartApp.views.orgchart.render( id );
                            });

                            $('.progress-loader-icon').hide();

                        }).fail( function(){ console.log( 'error!' ); });
                    else
                    // Call the view and render the main org chart page
                        window.OrgChartApp.views.orgchart.render( id );
                }

                /**
                 * Shows the search page
                 *
                 */
                ,   searchPage: function(){

                    window.OrgChartApp.views.orgchart.renderSearchPage();
                    $('.progress-loader-icon').hide();
                }
                /**
                 * Call the view function to render the
                 * org chart from item by id
                 *
                 */
                ,   search: function( term, page ){

                    if( term == '' )
                        return;

                    // Fetch data again, if collection is empty
                    if( window.OrgChartApp.views.orgchart.nodes.length == 0 )
                    // Fetch the data from https://api.myjson.com/bins/2gr36
                        $.getJSON( window.OrgChartApp.orgJSONPath, function(data){

                            // Transform into collection
                            window.OrgChartApp.views.orgchart.nodes.parse( data, function(){
                                // Call the view and render the main org chart page
                                window.OrgChartApp.views.orgchart._search( term, page );
                            });
                            $('.progress-loader-icon').hide();


                        }).fail( function(){ console.log( 'error!' ); });
                    else
                    // Call the view and render the main org chart page
                        window.OrgChartApp.views.orgchart._search( term, page );
                }


            });



            // Initiate the router
            window.OrgChartApp.routers.app = new OrgChartRouter();

            // Start Backbone history a necessary step for bookmarkable URL's
            Backbone.history.start();

            //});

        }
    }

})( jQuery, this, this.document, undefined );
//# sourceMappingURL=routers.js.map
