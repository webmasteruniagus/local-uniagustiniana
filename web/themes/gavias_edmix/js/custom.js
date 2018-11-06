(function($, undefined) {
    "use strict";

    var UniCustom = {},

        select_1 = "body.node--type-news",
        select_2 = ".field--name-dynamic-block-fieldnode-redes-sociales",
        select_3 = ".block-views-blockgrupo-contenido-block-4",
        select_4 = ".block-system-main-block .node--type-news",
        select_5 = "#menu-bartop",
        select_6 = ".topbar-right",
        select_7 = ".topbar-close",
        select_8 = ".sidebar-left .block-facets",
        select_9 = ".content-results",
        select_10 = ".all-filters",
        select_11 = ".filters",
        select_12 = select_9 + " > header",
        select_13 = ".sidebar-left",
        select_14 = "body",
        select_15 = ".close-filters",
        select_16 = ".facet-item",

        class_1 = "is--open",
        class_2 = "sidebar--fixed",
        class_3 = "page--filters",
        
        query_1;

    UniCustom = (function() {
        return {
            global_script: function() {
                $(window).on("resize", function() {
                    query_1 = window.matchMedia("(max-width: 991px)").matches;
                }).trigger("resize");

                // Abrir primer menú (naranja)
                $(select_5 + ', ' + select_7).on("click", function() {
                    if (query_1) {
                        $(select_6).toggleClass(class_1);
                    }
                });
            },

            news_page: function() {
                $(window).on("resize", function() {
                    let query = window.matchMedia("(max-width: 991px)").matches;

                    if (query) {
                        $(select_3).append($(select_2));
                    } else {
                        $(select_4).append($(select_2));
                    }
                }).trigger("resize");
            },

            page_filters: function() {
                let filtersDone = 0,
                    query = false,
                    linkFilters = "<div class='all-filters'><a href='#!' class='filters'>Filtros<i class='fa fa-arrow-right'></i></a></div>",
                    closeFilters = "<div class='close-filters'><a href='#!' class='close-content-filters'><i class='fa fa-arrow-left'></i>&nbsp; Atras</a></div>";

                $(window).on("resize", function() {
                    query = window.matchMedia("(max-width: 991px)").matches;

                    if (query) {
                        $(select_13).addClass(class_2);

                        if ($(select_10).length < 1) {
                            $('.'+class_2).prepend(closeFilters);
                            if ($(select_12).length > 0) {
                                $(select_12).append(linkFilters);
                            } else {
                                $(select_9).prepend(linkFilters);
                            }
                        }
                    } else {
                        $(select_10).remove();
                        $(select_15).remove();
                        $(select_13).removeClass(class_2);
                    }

                }).trigger("resize");

                // Abrir filtros
                $(select_11).on("click", function() {
                    $(select_14).addClass(class_3);
                    $('.' + class_2).addClass(class_1);
                });
                // Cerrar filtros
                $(select_15).on("click", function() {
                    $('.' + class_2).removeClass(class_1);

                    setTimeout(function() {
                        $(select_14).removeClass(class_3);
                    }, 500);
                });
                // Contar filtros realizados
                $(select_16).each(function() {
                    let actived = $(this).children('.is-active')[0] !== undefined ? true : false;
                    
                    if (actived) filtersDone += 1;
                });

                if (query) $(select_11 + ' .fa').before('<span>('+ filtersDone +') &nbsp;</span>');
            }
        };
    }());

    $(window).on("load", function() {
        // Global
        UniCustom.global_script();
        // Página de noticias
        if ($(select_1)) { UniCustom.news_page(); }
        // Página de resultados con filtros
        if ($(select_8)) { UniCustom.page_filters(); }
    });

}(jQuery));
