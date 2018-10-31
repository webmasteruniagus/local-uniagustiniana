(function($, window, undefined) {
    "use strict";

    var UniCustom = {},

        select_1 = 'body.node--type-news',
        select_2 = '.field--name-dynamic-block-fieldnode-redes-sociales',
        select_3 = '.block-views-blockgrupo-contenido-block-4',
        select_4 = '.block-system-main-block .node--type-news',
        
        query_1 = window.matchMedia("(max-width: 902px)");

    function queryMatch(query) {
        if (query.matches) {
            $(select_3).append($(select_2));
        } else {
            $(select_4).append($(select_2));
        }
    }

    UniCustom = (function() {
        return {
            // Página de noticias
            news_page: function() {
                queryMatch(query_1);
                query_1.addListener(queryMatch);
            }
        };
    }());

    window.onload = function() {
        if ($(select_1)) {
            UniCustom.news_page();
        }
    };
}(jQuery, window));
