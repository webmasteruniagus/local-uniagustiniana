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

        class_1 = "is--open",
        
        query_1;

    UniCustom = (function() {
        return {
            // Página de noticias
            news_page: function() {
                $(window).on("resize", function() {
                    let query = window.matchMedia("(max-width: 991px)").matches;

                    if (query) {
                        $(select_3).append($(select_2));
                    } else {
                        $(select_4).append($(select_2));
                    }
                }).trigger("resize");
            }
        };
    }());

    window.onload = function() {
        if ($(select_1)) { UniCustom.news_page(); }
    };
    // Global resize
    $(window).on("resize", function() {
        query_1 = window.matchMedia("(max-width: 991px)").matches;
        
        // Abrir primer menú (naranja)
        $(select_5 + ', ' + select_7).on("click", function() {
            if (query_1) {
                $(select_6).toggleClass(class_1);
            }
        });

    }).trigger("resize");
}(jQuery));
