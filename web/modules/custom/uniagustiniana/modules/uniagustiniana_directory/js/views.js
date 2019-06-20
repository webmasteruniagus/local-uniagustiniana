/**
* View for org chart
* Manages the org chart view
*
* @author: Brian Serano Satizabal
* @author-email: deywibkiss@gmail.com
* @app-version: 0.0.1
*
*/
( function( $, window, document, misc ){

    Drupal.behaviors.intranet_org_chart_file5 = {
        attach: function (context, settings) {

    	'use-strict';

        //jQuery('body').once('path-directory', function(){
            var OrgChartView = Backbone.View.extend({

                el: $( '#org-chart-canvas' )

                /**
                * Define the view events
                *
                */
            ,   events: {

                    'click #org-back-button': 'back',
                    'click .item-data h2': 'showDescription',
                    'click .org-close-description-item': 'closeDescription',
                    'submit #org-search-form': 'search'
                }

            ,   nodes: new treeNodes

            ,   results: new treeNodes

            ,   initialize: function(){

                    // Bind all events so this variable could
                    // be the view in function scopes
                    _.bindAll(

                        this,
                        'render',
                        'renderMain',
                        'closeDescription',
                        'showDescription',
                        'search'
                    );

                }

                /**
                * render the main page of the org chart
                *
                */
            ,   renderMain: function(){

                    $('.progress-loader-icon').show();

                    var data = {};

                    // Get consejo directivo
                    data.consejo = this.nodes.at(0);

                    // Get rectoria
                    data.rectoria = this.nodes.at(1);

                    // Get the data
                    data.rectoriaChildren = this.nodes.where( { dependencia: this.nodes.at(1).get('id'), nivel: "3" });

                    $( '#org-chart-canvas' ).html(
                        new EJS({ url: window.OrgChartApp.orgChartTmpPath + 'main.ejs' }).render(data)
                    );

                    //$(".ut-org-chart-draw").orgChart({container: $("#org-chart-draw-container"), stack: false, depth: 3});


                }

                /**
                * Render the chart from subitem
                *
                * @param { numeric } the id of the parent item
                *
                */
            ,   render: function( id ){

                    //$('.progress-loader-icon').show();

                    var data = {};

                    // Get the data
                    data.parent = this.nodes.findWhere({ id: id });
                    data.children = [];

                    data.children[0] = {
                        level: 4,
                        items: this.nodes.where({ dependencia: id, nivel: "4" })
                    };

                    data.children[1] = {
                        level: 3,
                        items: this.nodes.where({ dependencia: id, nivel: "3" })
                    };


                    data.children[2] = {
                        items: this.nodes.getChildren({ dependencia: id }).notInLevel(["2","3","4"])
                    };


                    $( '#org-chart-canvas' ).html(
                        new EJS({ url: window.OrgChartApp.orgChartTmpPath + 'subchart.ejs' }).render(data)
                    );

                    //$(".ut-org-chart-draw").orgChart({container: $("#org-chart-draw-container"), stack: false, depth: 3});


                }

                /**
                * Returns to the previous page
                *
                */
            ,   back: function( e ){

                    e.preventDefault();

                    window.history.back();

                }

                /**
                * Shows the description over an item on sub charts
                *
                */
            ,   showDescription: function(e){

                    var target = e.currentTarget;

                    $( target ).parent('.item-data').siblings('.item-description').fadeIn();


                }


                /**
                * Close the description displayed over an item on sub charts
                *
                */
            ,   closeDescription: function(e){

                    e.preventDefault();

                    var target = e.currentTarget;

                    $( target ).parent('.item-description').fadeOut();

                }


                /**
                * Renders the search page
                *
                */
            ,   renderSearchPage: function(){

                    //$('.progress-loader-icon').show();
                    // load the template
                    $( '#org-chart-canvas' ).html(
                        new EJS({ url: window.OrgChartApp.orgChartTmpPath + 'search.ejs' }).render({})
                    );

                }


                /**
                * Searchs an item by name or area
                *
                */
            ,   search: function(e){

                    e.preventDefault();

                    var term = $( '#org-search-form input' ).val();

                    window.OrgChartApp.routers.app.navigate("org/search/" + term + "/1", {trigger: true} );



                }

            ,   _search: function( term, page ){

                    //$('.progress-loader-icon').show();

                    if( _.isNull(page) || _.isUndefined(page) )
                        page = 1

                    // Get all the nodes by name and area
                    this.results = this.nodes.search([{nombre: term}, {area:term},{cargo:term},{ciudad:term}]);

                    // Get the page items
                    var items = new treeNodes();
                    var end = (13 * page) + 1;
                    var begin = (13 * page) - (12);

                    if( page == 1 ){
                        begin = 0;
                        end = 13;
                    }

                    items.models = this.results.slice( begin, end );

                    items.reset(items.models);


                    // load the template
                    $( '#org-chart-canvas' ).html(
                        new EJS({ url: window.OrgChartApp.orgChartTmpPath + 'results.ejs' }).render({
                            items:items,
                            total: this.results.length,
                            term: term,
                            page: page
                        })
                    );


                }


        });

        // Initiate the router
        window.OrgChartApp.views.orgchart = new OrgChartView();

        //});

        }

    }



})( jQuery, this, this.document, this.Misc, undefined );
//# sourceMappingURL=views.js.map
