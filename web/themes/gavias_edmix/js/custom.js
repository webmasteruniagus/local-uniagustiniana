(function ($, Drupal) {
  "use strict";

  /**
   * @file custom.js
   * @desc Código JavaScript personalizado
   * @version 30112018
   * @author William Bautista
   */

  /** @namespace */
  var UniCustom = {},

    select_1 = ".sidebar-right .views-element-container",
    select_2 = ".field--name-dynamic-block-fieldnode-redes-sociales",
    select_3 = ".content-main",
    select_4 = ".gva_topbar_menu",
    select_5 = ".right-topbar-h",
    select_6 = ".gva_menu_main",
    select_7 = ".menu_rol",
    select_8 = ".sidebar-left .block-facets",
    select_9 = ".content-results",
    select_10 = ".all-filters",
    select_11 = ".filters",
    select_12 = select_9 + " > header",
    select_13 = ".sidebar-left",
    select_14 = "body",
    select_15 = ".close-filters",
    select_16 = ".facet-item",
    select_17 = ".tabs_wrapper",
    select_18 = ".group--type-programa",
    select_19 = ".field--name-field-color-principal",
    select_20 = ".field--name-field-color-secundario",
    select_21 = ".content-on-image",
    select_22 = ".field--name-field-imagen",
    select_23 = ".profile",
    select_24 = ".characteristics",
    select_25 = ".block-uniagustiniana > div",
    select_26 = ".field--name-field-color-texto",
    select_27 = ".services-news",
    select_28 = ".gsc-column",
    select_29 = ".gva-search-region",
    select_30 = "#header",
    select_31 = ".search-content",
    select_32 = ".webform-submission-curso-form",

    element_1,
    element_2,
    element_3,

    regex_1 = /[^a-z A-Z ñáéíóú ÁÉÍÓÚÜÑ]+/g,
    regex_2 = /(^|[^A-Za-zÁÉÍÓÚÜÑáéíóúüñ])([a-záéíóúüñ])/g,
    regex_3 = /[^0-9]+/g,

    class_1 = "is--open",
    class_2 = "sidebar--fixed",
    class_3 = "page--filters",
    class_4 = "gva_menu",
    class_5 = "page-program",
    class_6 = "tabs_horizontal",
    class_7 = "tabs_vertical",

    query_1;

  /**
   * @returns {object} Objeto con funciones publicas
   */
  UniCustom = (function () {
    /* Private */
    let mq1 = window.matchMedia('(max-width: 991px)');

    /**
     * Obtener ancho de la barra de scroll
     * @property {Function} getScrollBarWidth
     * @returns {number} ancho en px de la barra de scroll
     */
    function getScrollBarWidth() {
      return window.innerWidth - document.documentElement.getBoundingClientRect().width;
    }

    /**
     * Crear variable css
     * @property {Function} createVariableCss
     * @param {string} name nombre de variable a crear
     * @param {string} value - valor asigando a la variable
     */
    function createVariableCss(name, value) {
      document.documentElement.style.setProperty(`--${name}`, value);
    }

    function moveMenuRol(e) {
      let select1 = document.querySelector(select_6),
        select2 = document.querySelector(select_7),
        select3 = document.querySelector(select_4) ?
        document.querySelector(select_4) :
        false,
        parent1 = document.querySelector(select_5),
        parent2 = document.querySelector(select_25);

      if (e.matches) {
        select2.classList.add(class_4);
        select1.parentNode.insertBefore(select2, select1);

        if (select3) {
          select3.classList.add(class_4);
          select1.parentNode.insertBefore(select3, select1);
        }
      } else {
        select2.classList.remove(class_4);
        parent2.append(select2);

        if (select3) {
          select3.classList.remove(class_4);
          parent1.prepend(select3);
        }
      }
    }

    /* Public */
    return {
      global_script: function () {
        $(window).on("resize", function () {
          query_1 = window.matchMedia("(max-width: 991px)").matches;

          // Mover formulario en programa para dispositivos móviles
          if ($(select_18).length > 0 && $(element_3).length < 1) {
            let calcPading = ($(select_21).innerHeight() - $(select_22).innerHeight()) + 20;

            if (query_1) {
              $(select_24).css('padding-top', calcPading);
              $(select_23).css('padding-top', 0);
            } else {
              $(select_24).css('padding-top', 0);
              $(select_23).css('padding-top', calcPading);
            }
          } else {
						$(select_21).addClass('exist-message');
					}
        }).trigger("resize");

        // Crear variable con el ancho de la barra de scroll
        createVariableCss('scrollWidth', getScrollBarWidth());

        // Escuchar cambio en media query
        mq1.addListener(moveMenuRol);
        moveMenuRol(mq1);

        if ($(select_29).length > 0) {
          $(select_29 + ' i').on('click', function () {
            $(select_31).css({
              position: 'fixed',
              top: $(select_30)[0].clientHeight,
              right: 0
            });
          });
        }
      },

      move_networks: function () {
        $(window).on("resize", function () {
          let query = window.matchMedia("(max-width: 991px)").matches;

          if (query) {
            $(select_1).append($(select_2));
          } else {
            $(select_3).append($(select_2));
          }
        }).trigger("resize");
      },

      page_filters: function () {
        let filtersDone = 0,
          query = false,
          linkFilters = "<div class='all-filters'><a href='#!' class='filters'>Filtros<i class='fa fa-arrow-right'></i></a></div>",
          closeFilters = "<div class='close-filters'><a href='#!' class='close-content-filters'><i class='fa fa-arrow-left'></i>&nbsp; Atras</a></div>";

        $(window).on("resize", function () {
          query = window.matchMedia("(max-width: 991px)").matches;

          if (query) {
            $(select_13).addClass(class_2);

            if ($(select_10).length < 1) {
              $('.' + class_2).prepend(closeFilters);
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
        $(select_11).on("click", function () {
          $(select_14).addClass(class_3);
          $('.' + class_2).addClass(class_1);
        });
        // Cerrar filtros
        $(select_15).on("click", function () {
          $('.' + class_2).removeClass(class_1);

          setTimeout(function () {
            $(select_14).removeClass(class_3);
          }, 500);
        });
        // Contar filtros realizados
        $(select_16).each(function () {
          let actived = $(this).children('.is-active')[0] !== undefined;

          if (actived) filtersDone += 1;
        });

        if (query) $(select_11 + ' .fa').before('<span>(' + filtersDone + ') &nbsp;</span>');
      },

      facultad_acordeon: function () {
        $(window).on("resize", function () {
          let query = window.matchMedia("(max-width: 767px)").matches;

          if (query) {
            $(select_17).removeClass(class_7);
            $(select_17).addClass(class_6);
          } else {
            $(select_17).addClass(class_7);
            $(select_17).removeClass(class_6);
          }
        }).trigger("resize");
      },

      paginaPrograma: function () {
        // Color del programa mandado desde administración
        let mainColor = $(select_19).text().split(' '),
          mainColorOpacity = mainColor[1],
          textColor = $(select_26).text(),
          secondColor = $(select_20).text();

        document.querySelector('body').classList.add(class_5);

        createVariableCss('color_1', mainColor[0]);
        createVariableCss('opacity_1', mainColorOpacity);
        createVariableCss('color_2', secondColor);
        createVariableCss('color_3', textColor);

      },

      students: function () {
        $(select_27 + ' ' + select_28 + ':not(.col-lg-12)').click(function (e) {
          let url = $(this).find('.title a').attr('href');
          location.href = url;
        });
      },

      hide_form: () => {
        $(select_32).submit(function () {
          $(this).hide();
        });
      },

      hide_message: () => {
        setTimeout(() => {
          $(element_3).hide('slow');
        }, 10000);
      },

      format_input_text: () => {
        const events = ["keyup", "blur"]
        let value_o

        Array.from(element_1).map(el => {
          events.map(event => {
            el.addEventListener(event, () => {
              value_o = el.value.replace(regex_1, "")
              el.value = value_o.toLowerCase().replace(regex_2, w => w.toUpperCase())
            })
            el.dispatchEvent(new Event(event));
          })
        })
      },

      format_input_number: () => {
        const events = ["keyup", "blur"]
        let value_o

        Array.from(element_2).map(el => {
          events.map(event => {
            el.addEventListener(event, () => {
              value_o = el.value.replace(regex_3, "")
              el.value = value_o
            })
            el.dispatchEvent(new Event(event));
          })
        })
      }
    };
  }());

  $(window).on("load", function () {
		element_3 = document.querySelector('.gav-help-region [data-drupal-messages]');

		if ($(element_3).length > 0 && $(select_18).length > 0) {
		  UniCustom.hide_message();
		}
    // Global
    UniCustom.global_script();
    // Página de noticias
    if ($(select_1).length > 0 && $(select_2).length > 0) {
      UniCustom.move_networks();
    }
    // Página de resultados con filtros
    if ($(select_8).length > 0) {
      UniCustom.page_filters();
    }
    // Página de facultad
    if ($(select_17).length > 0) {
      UniCustom.facultad_acordeon();
    }
    // Página de estudiantes
    if ($(select_27).length > 0) {
      UniCustom.students();
    }
    // Formulario de interna de programa
    if ($(select_32).length > 0) {
      UniCustom.hide_form();
		}
  });

  $(document).ready(function () {
    if ($(select_18).length > 0) {
      UniCustom.paginaPrograma();
		}
  })

  Drupal.behaviors.inputsValidations = {
    attach: function (context, settings) {
      element_1 = document.querySelectorAll('input[data-input-text]');
			element_2 = document.querySelectorAll('input[data-input-number]');

      // Inputs de texto
      if ($(element_1, context).length > 0) {
        UniCustom.format_input_text();
      }

      // Inputs de texto
      if ($(element_2, context).length > 0) {
        UniCustom.format_input_number();
			}
    }
  }

}(jQuery, Drupal));
