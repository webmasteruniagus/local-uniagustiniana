(function($, undefined) {
    "use strict";

    var UniCustom = {},

        select_1 = 'body.node--type-news',
        select_2 = '.field--name-dynamic-block-fieldnode-redes-sociales',
        select_3 = '.block-views-blockgrupo-contenido-block-4',
        select_4 = '.block-system-main-block .node--type-news';

    UniCustom = (function() {
        return {
            // Página de noticias
            news_page: function() {
                $(window).on("resize", function() {
                    let query_1 = window.matchMedia("(max-width: 991px)").matches;

                    if (query_1) {
                        $(select_3).append($(select_2));
                    } else {
                        $(select_4).append($(select_2));
                    }
                }).trigger("resize");
            }
        };
    }());

    window.onload = function() {
        if ($(select_1)) {
            UniCustom.news_page();
        }
    };
}(jQuery));
