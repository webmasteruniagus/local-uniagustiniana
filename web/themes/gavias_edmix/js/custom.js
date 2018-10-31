(function($, window, undefined) {
    "use strict";

    var UniCustom = {},

        select_1 = 'body.node--type-news',
        select_2 = '.field--name-dynamic-block-fieldnode-redes-sociales',
        select_3 = '.block-views-blockgrupo-contenido-block-4',
        select_4 = '.block-system-main-block .node--type-news',
        select_5 = '.node--type-event',
        select_6 = '.field--type-datetime time',
        
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
            },
            // Página de eventos
            event_page: function() {
                $(select_6).map( (ind, obj) => {
                    var monthNumber = $(obj).text().split('-'),
                        monthName = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
                        newDate = monthNumber[1] + '<span>' + monthName[parseInt(monthNumber[0] - 1)] + '</span>';
                    $(obj).html(newDate);
                });
                
            }
        };
    }());

    window.onload = function() {
        if ($(select_1)) {
            UniCustom.news_page();
        }
        if ($(select_5)) {
            UniCustom.event_page();
        }
    };
}(jQuery, window));
