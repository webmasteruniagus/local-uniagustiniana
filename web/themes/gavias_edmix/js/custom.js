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
            document.querySelector(select_3).appendChild(document.querySelector(select_2));
        } else {
            document.querySelector(select_4).appendChild(document.querySelector(select_2));
        }
    }

    UniCustom = (function() {
        return {
            news_page: function() {
                queryMatch(query_1);
                query_1.addListener(queryMatch);
            }
        };
    }());

    window.onload = function() {
        if (document.querySelector(select_1)) {
            UniCustom.news_page();
        }
    };
}(jQuery, window));
