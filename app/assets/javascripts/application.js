// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap
//= require jquery_ujs
//= require Chart.min
//= require_tree .


$(function () {
    $('.decision-slider').change(function (e) {
        console.log("Value has Changed!");
        var theValue = $(this).val();
        var the_id = $(this)[0].id;
        console.log("Value is " + theValue);
        var parent = $(this).closest('.row');
        var valueBox = parent.find('.decision-value');
        valueBox.text(theValue);
        var theTrigger = channel.trigger('client-update', {
            type: "text",
            id: the_id,
            contents: theValue
        });
    });
    $('.next-button').click(function (e) {
        console.log("I clicked the next button!");
        var theForm = $(this).closest('form');
        theForm.submit();
    });
    $('.synced-select-input').change(function () {
        console.log("Select Value d Changed!")
        var the_value = $(this).val();
        var the_id = $(this)[0].id;
        console.log("The id is " + the_id);
        var theTrigger = channel.trigger('client-update', {
            type: "text",
            id: the_id,
            contents: the_value
        });

        var original_value = $(this).data('original-value');
        console.log(" Orginal Value is " + original_value + " Numeruc is " + the_value);
        if (original_value == the_value) {
            console.log("Adding the Class for orginal!");
            $(this).addClass("original-decision-value");
        } else {
            console.log("Romoving the class");
            $(this).removeClass("original-decision-value");
        }
    });
    $('.synced-input').change(function (e) {
        console.log("Hey I changed an Input!");
        the_id = $(this).attr('id');
        the_value = $(this).val();
        var value_to_post = the_value;
        var original_value = $(this).data('original-value');


        var input_screen_id = $(this).data('input-screen-id');
        var max_value = parseFloat($(this).data('max-value'));

        var min_value = parseFloat($(this).data('min-value'));

        if ($(this).attr("type") == "text") {
            // Check Validity
            console.log("Checking Text for validity")
            // vat the_numeric_value =
            var the_numeric_value = parseFloat(the_value.replace(/,/g, ''));
            console.log(the_numeric_value);
            console.log(max_value);
            console.log(min_value);
            console.log(original_value);
            if (isNaN(the_numeric_value)) {
                alert("This value needs to be a number between " + min_value + " and " + max_value + ". Resetting to starting value.");
                $(this).val(original_value);
                console.log(channel);
                the_numeric_value = parseFloat(original_value);
                the_value = original_value;
                var theTrigger = channel.trigger('client-update', {
                    type: "text",
                    id: the_id,
                    contents: "" + original_value,
                });

            }
            if (the_numeric_value > max_value || the_numeric_value < min_value) {
                alert("This value falls outside of the accepted range (" + min_value + "-" + max_value + "). Resetting to starting value.");
                $(this).val(original_value);
                the_numeric_value = parseFloat(original_value);
                the_value = original_value;
                var theTrigger = channel.trigger('client-update', {
                    type: "text",
                    id: the_id,
                    contents: original_value
                });

            }
            value_to_post = the_numeric_value;
            var decimalPlaces = parseInt($(this).data('decimal-places'));
            // the_numeric_value = 10000000.04
            console.log("Number is " + the_numeric_value)
            var str = the_numeric_value.toLocaleString("en-us", {
                minimumFractionDigits: decimalPlaces,
                maximumFractionDigits: decimalPlaces
            });
            console.log("Formatted is " + str);
            console.log(the_numeric_value.toLocaleString("en-us"));
            $(this).val(str);
            console.log("Original Value " + original_value + "  Value " + the_numeric_value)
            if (original_value == the_numeric_value) {
                $(this).addClass("original-decision-value");
            } else {
                $(this).removeClass("original-decision-value");
            }
            console.log(" Value of " + the_id + " is " + the_value);
        } else if ($(this).attr("type") == "range") {
            console.log("Got A Range item");
        }

        $.ajax({
            method: "POST",
            url: "/input_screen/update_decision_field",
            data:
                {field_id: the_id, field_value: value_to_post, input_screen_id: input_screen_id}
        })
            .done(function (msg) {
                // $.toaster({  title : 'Success', message : msg});
            });
    });

    $(".numeric-input").each(function () {
        var the_value = $(this).attr("value");
        console.log("The Value is " + the_value)
        var the_numeric_value = parseFloat(the_value.replace(/,/g, ''));
        var decimalPlaces = parseInt($(this).data('decimal-places'));
        // the_numeric_value = 10000000.04
        console.log("Number is " + the_numeric_value)
        var str = the_numeric_value.toLocaleString("en-us", {
            minimumFractionDigits: decimalPlaces,
            maximumFractionDigits: decimalPlaces
        });
        console.log("The New Value is " + str);
        $(this).val(str);
    });

    setTimeout(function () {
        $('.alert').slideUp(500);
    }, 1000);


    $("#asset_liability_management_fed_funds_purchased,#asset_liability_management_commercial_paper,#asset_liability_management_funding_mix_securtize_variable_rate_mortgage_recievables,#asset_liability_management_funding_mix_securitize_fixed_rate_mortgage_recievables").change(function () {
        update_totals();
    })


});

function update_data_from_pusher(data) {
    var the_input = $('#' + data['id']);
    if (the_input.hasClass("decision-slider")) {
        var the_new_value = data['contents'];
        var theValue = the_input.val(the_new_value);
        console.log("Value is " + the_new_value);
        var parent = the_input.closest('.row');
        var valueBox = parent.find('.decision-value');
        valueBox.text(the_new_value);

    } else if (the_input.hasClass("synced-select-input")) {
        var the_new_value = data['contents'];
        var theValue = the_input.val(the_new_value);
        // OK Let's get the Original value thing set
        var original_value = the_input.data('original-value');
        console.log(" Orginal Value is " + original_value + " Numeruc is " + the_numeric_value);
        if (original_value == the_new_value) {
            console.log("Adding the Class for orginal!");
            the_input.addClass("original-decision-value");
        } else {
            console.log("Romoving the class");
            the_input.removeClass("original-decision-value");
        }
    } else {
        var the_new_value = data['contents'];
        var the_numeric_value;
        console.log(the_new_value);
        console.log(typeof the_new_value);
        console.log(isNaN(the_new_value));
        if (!isNaN(the_new_value)) {
            console.log("It is a Number!");
            the_new_value = the_new_value + "";
        }

        console.log("It's a string!");
        the_numeric_value = parseFloat(the_new_value.replace(/,/g, ''));


        var decimalPlaces = parseInt(the_input.data('decimal-places'));
        // the_numeric_value = 10000000.04
        console.log("Number is " + the_numeric_value)
        var str = the_numeric_value.toLocaleString("en-us", {
            minimumFractionDigits: decimalPlaces,
            maximumFractionDigits: decimalPlaces
        });
        console.log("Formatted is " + str);
        console.log(the_numeric_value.toLocaleString("en-us"));

        var the_element = $('#' + data['id']).val(str);
        var original_value = the_input.data('original-value');
        console.log(" Orginal Value is " + original_value + " Numeruc is " + the_numeric_value);
        if (+original_value == +the_numeric_value) {
            console.log("Adding the Class for orginal!");
            the_input.addClass("original-decision-value");
        } else {
            console.log("Romoving the class");
            the_input.removeClass("original-decision-value");
        }
    }
}

function update_totals() {
    var sum = 0;
    var el1 = $('#asset_liability_management_fed_funds_purchased');
    sum = sum + parseFloat(el1.val());
    var el2 = $('#asset_liability_management_commercial_paper');
    sum = sum + parseFloat(el2.val());
    var el3 = $('#asset_liability_management_funding_mix_securtize_variable_rate_mortgage_recievables');
    sum = sum + parseFloat(el3.val());
    var el4 = $('#asset_liability_management_funding_mix_securitize_fixed_rate_mortgage_recievables');
    sum = sum + parseFloat(el4.val());
    console.log("Changed Them!");

    $("#total-funding-mix").text("Total Funding Mix (should equal 100%): " + sum + "%");
}

Chart.defaults.global.layout = {
    padding: {
        left: 50,
        right: 0,
        top: 20,
        bottom: 0
    }
}
Chart.defaults.global.legend.display = false;

function formatNumber(number) {
    var str = the_numeric_value.toLocaleString("en-us", {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    });
}

if (typeof String.prototype.endsWith !== 'function') {
    String.prototype.endsWith = function (suffix) {
        return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
}
/*global $, window*/
console.log("Loaded it ")
$.fn.editableTableWidget = function (options) {
    'use strict';
    return $(this).each(function () {
        var buildDefaultOptions = function () {
                var opts = $.extend({}, $.fn.editableTableWidget.defaultOptions);
                opts.editor = opts.editor.clone();
                return opts;
            },
            activeOptions = $.extend(buildDefaultOptions(), options),
            ARROW_LEFT = 37, ARROW_UP = 38, ARROW_RIGHT = 39, ARROW_DOWN = 40, ENTER = 13, ESC = 27, TAB = 9,
            element = $(this),
            editor = activeOptions.editor.css('position', 'absolute').hide().appendTo(element.parent()),
            active,
            showEditor = function (select) {
                console.log("In show Editor ");
                console.log(select)
                active = element.find('.editable:focus');
                if (active.length) {
                    console.log("OK We're changing one!")
                    editor.val(active.text())
                        .removeClass('error')
                        .show()
                        .offset(active.offset())
                        .css(active.css(activeOptions.cloneProperties))
                        .width(active.width())
                        .height(active.height())
                        .focus();
                    if (select) {
                        editor.select();
                    }
                }
            },
            setActiveText = function () {
                console.log("Set Active Text");
                window.is_dirty = true;
                recalculate_form();
                var text = editor.val(),
                    evt = $.Event('change'),
                    originalContent;
                text = text.trim();
                originalContent = active.html();
                if (active.hasClass("restrict-change")) {
                    console.log("Old " + active.text());
                    console.log("New " + editor.val());
                    console.log(active);
                    var old_value = parseFloat(active.attr('previous_round_value'));
                    var new_value = parseFloat(editor.val());
                    console.log("NewVal " + new_value + " Old " + old_value)
                    var percent_diff = Math.abs(old_value - new_value);

                    console.log("Percent Diff is " + percent_diff)
                    if (percent_diff > 3.0) {
                        $.toaster({
                            priority: 'danger',
                            title: 'Input Error',
                            message: 'Capital allocations for each business unit cannot be increased or decreased by more than 3% from the previous round. Please edit your decision.'
                        });
                        active.html = originalContent;
                        return true;
                    }
                }

                text = remove_whitespace_and_percent(text)
                if (!is_valid_entry(text)) {
                    active.html = originalContent;
                    $.toaster({priority: 'danger', title: 'Input Error', message: 'This Field Must be a Number'});
                    return true;
                }
                text = make_sure_has_ending_percent(text)
                console.log("Text is " + text);
                if (active.text() === text || editor.hasClass('error')) {
                    console.log("No Change Needed");
                    return true;
                }
                console.log("Original Content " + originalContent)
                active.text(text).trigger(evt, text);
                if (evt.result === false) {
                    console.log("Setting..");
                    active.html(originalContent);
                }
            },
            movement = function (element, keycode) {
                if (keycode === ARROW_RIGHT) {
                    return element.next('td');
                } else if (keycode === ARROW_LEFT) {
                    return element.prev('td');
                } else if (keycode === ARROW_UP) {
                    return element.parent().prev().children().eq(element.index());
                } else if (keycode === ARROW_DOWN) {
                    return element.parent().next().children().eq(element.index());
                }
                return [];
            };
        editor.blur(function () {
            console.log("Blur")
            setActiveText();
            editor.hide();
            recalculate_form();
        }).keydown(function (e) {
            if (e.which === ENTER) {
                console.log("Hit Enter");
                var el = $(active).get(0);
                console.log(active.hasClass("restrict-change"));
                var text = remove_whitespace_and_percent(editor.val())
                if (is_valid_entry(text)) {
                    var out_of_range = false;
                    if (active.hasClass("restrict-change")) {
                        console.log("Old " + active.text());
                        console.log("New " + editor.val());
                        var old_value = parseFloat(active.text());
                        var new_value = parseFloat(text);
                        console.log("NewVal " + new_value + " Old " + old_value)
                        var percent_diff = Math.abs(old_value - new_value);

                        console.log("Percent Diff is " + percent_diff)
                        if (percent_diff > 3.0) {
                            out_of_range = true;
                        }
                    }
                    if (!out_of_range) {
                        setActiveText();
                        editor.hide();
                        active.focus();
                    } else {
                        $.toaster({
                            priority: 'danger',
                            title: 'Input Error',
                            message: 'Capital allocations for each business unit cannot be increased or decreased by more than 3% from the previous round. Please edit your decision.'
                        });
                        editor.val(active.text().trim());
                    }

                } else {
                    $.toaster({priority: 'danger', title: 'Input Error', message: 'This Field Must be a Number'});
                }
                e.preventDefault();
                e.stopPropagation();
            } else if (e.which === ESC) {
                editor.val(active.text());
                e.preventDefault();
                e.stopPropagation();
                editor.hide();
                active.focus();
            } else if (e.which === TAB) {
                console.log(active.text());
                console.log(editor.text());
                active.focus();
            } else if (this.selectionEnd - this.selectionStart === this.value.length) {
                var possibleMove = movement(active, e.which);
                if (possibleMove.length > 0) {
                    possibleMove.focus();
                    e.preventDefault();
                    e.stopPropagation();
                }
            }
        })
            .on('input paste', function () {
                var evt = $.Event('validate');
                active.trigger(evt, editor.val());
                if (evt.result === false) {
                    editor.addClass('error');
                } else {
                    editor.removeClass('error');
                }
            });
        element.on('click keypress dblclick', showEditor)
            .css('cursor', 'pointer')
            .keydown(function (e) {
                var prevent = true,
                    possibleMove = movement($(e.target), e.which);
                if (possibleMove.length > 0) {
                    possibleMove.focus();
                } else if (e.which === ENTER) {
                    console.log("enter is hit");
                    showEditor(false);
                } else if (e.which === 17 || e.which === 91 || e.which === 93) {
                    showEditor(true);
                    prevent = false;
                } else {
                    prevent = false;
                }
                if (prevent) {
                    e.stopPropagation();
                    e.preventDefault();
                }
            });

        element.find('.editable').prop('tabindex', 1);

        $(window).on('resize', function () {
            if (editor.is(':visible')) {
                editor.offset(active.offset())
                    .width(active.width())
                    .height(active.height());
            }
        });
    });

};
$.fn.editableTableWidget.defaultOptions = {
    cloneProperties: ['padding', 'padding-top', 'padding-bottom', 'padding-left', 'padding-right',
        'text-align', 'font', 'font-size', 'font-family', 'font-weight',
        'border', 'border-top', 'border-bottom', 'border-left', 'border-right'],
    editor: $('<input>')
};

function recalculate_form() {
    $.each($('.additive-result'), function (idx, val) {
            //       console.log("Found One");
            //       console.log(val);
            fields_to_add = val.getAttribute('data-add-fields');
            //        console.log("Fields to Add are");
            //        console.log(fields_to_add);
            total = 0;
            $.each(fields_to_add.split(","), function (i, v) {
                //          console.log("OK Adding")
                //          console.log(v);
                theEl = $('#' + v)[0];
                //        console.log(theEl);
                theVal = parseFloat(theEl.innerText);
                //              console.log("The Val is ");
                //            console.log(theVal);
                total = total + theVal;
            });
            theOutputString = total + "%"
            val.innerText = theOutputString;
        }
    )
}

function make_sure_has_ending_percent(str) {
    str = str.replace(/%/g, "").trim();
    str = str + "%";
    return str;
}

function remove_whitespace_and_percent(str) {
    console.log("Remove Whitespace " + str);
    str = str.replace(/[^0-9.]/g, "").trim();
    console.log("Out is " + str);
    return str
}


function is_valid_entry(txt) {
    txt = remove_whitespace_and_percent(txt);
    console.log("Looking for a number");
    console.log(txt);
    theVal = parseFloat(txt);
    if (isNaN(theVal)) {
        console.log("NAN");
        return false;
    }
    if (theVal < 0 || theVal > 100) {
        console.log("Range Exceed");
        return false;
    }
    return true;
}


// $('.input-screen-table').editableTableWidget();


/***********************************************************************************
 * Add Array.indexOf                                                                *
 ***********************************************************************************/
(function () {
    if (typeof Array.prototype.indexOf !== 'function') {
        Array.prototype.indexOf = function (searchElement, fromIndex) {
            for (var i = (fromIndex || 0), j = this.length; i < j; i += 1) {
                if ((searchElement === undefined) || (searchElement === null)) {
                    if (this[i] === searchElement) {
                        return i;
                    }
                } else if (this[i] === searchElement) {
                    return i;
                }
            }
            return -1;
        };
    }
})();
/**********************************************************************************/

(function ($, undefined) {
    var toasting =
        {
            gettoaster: function () {
                var toaster = $('#' + settings.toaster.id);

                if (toaster.length < 1) {
                    toaster = $(settings.toaster.template).attr('id', settings.toaster.id).css(settings.toaster.css).addClass(settings.toaster['class']);

                    if ((settings.stylesheet) && (!$("link[href=" + settings.stylesheet + "]").length)) {
                        $('head').appendTo('<link rel="stylesheet" href="' + settings.stylesheet + '">');
                    }

                    $(settings.toaster.container).append(toaster);
                }

                return toaster;
            },

            notify: function (title, message, priority) {
                var $toaster = this.gettoaster();
                var $toast = $(settings.toast.template.replace('%priority%', priority)).hide().css(settings.toast.css).addClass(settings.toast['class']);

                $('.title', $toast).css(settings.toast.csst).html(title);
                $('.message', $toast).css(settings.toast.cssm).html(message);

                if ((settings.debug) && (window.console)) {
                    console.log(toast);
                }

                $toaster.append(settings.toast.display($toast));

                if (settings.donotdismiss.indexOf(priority) === -1) {
                    var timeout = (typeof settings.timeout === 'number') ? settings.timeout : ((typeof settings.timeout === 'object') && (priority in settings.timeout)) ? settings.timeout[priority] : 3500;
                    setTimeout(function () {
                        settings.toast.remove($toast, function () {
                            $toast.remove();
                        });
                    }, timeout);
                }
            }
        };

    var defaults =
        {
            'toaster':
                {
                    'id': 'toaster',
                    'container': 'body',
                    'template': '<div></div>',
                    'class': 'toaster',
                    'css':
                        {
                            'position': 'fixed',
                            'top': '10px',
                            'right': '10px',
                            'width': '300px',
                            'zIndex': 50000
                        }
                },

            'toast':
                {
                    'template':
                        '<div class="alert alert-%priority% alert-dismissible" role="alert">' +
                        '<button type="button" class="close" data-dismiss="alert">' +
                        '<span aria-hidden="true">&times;</span>' +
                        '<span class="sr-only">Close</span>' +
                        '</button>' +
                        '<span class="title"></span>: <span class="message"></span>' +
                        '</div>',

                    'defaults':
                        {
                            'title': 'Notice',
                            'priority': 'success'
                        },

                    'css': {},
                    'cssm': {},
                    'csst': {'fontWeight': 'bold'},

                    'fade': 'slow',

                    'display': function ($toast) {
                        return $toast.fadeIn(settings.toast.fade);
                    },

                    'remove': function ($toast, callback) {
                        return $toast.animate(
                            {
                                opacity: '0',
                                padding: '0px',
                                margin: '0px',
                                height: '0px'
                            },
                            {
                                duration: settings.toast.fade,
                                complete: callback
                            }
                        );
                    }
                },

            'debug': false,
            'timeout': 3500,
            'stylesheet': null,
            'donotdismiss': []
        };

    var settings = {};
    $.extend(settings, defaults);

    $.toaster = function (options) {
        if (typeof options === 'object') {
            if ('settings' in options) {
                settings = $.extend(true, settings, options.settings);
            }
        } else {
            var values = Array.prototype.slice.call(arguments, 0);
            var labels = ['message', 'title', 'priority'];
            options = {};

            for (var i = 0, l = values.length; i < l; i += 1) {
                options[labels[i]] = values[i];
            }
        }

        var title = (('title' in options) && (typeof options.title === 'string')) ? options.title : settings.toast.defaults.title;
        var message = ('message' in options) ? options.message : null;
        var priority = (('priority' in options) && (typeof options.priority === 'string')) ? options.priority : settings.toast.defaults.priority;

        if (message !== null) {
            toasting.notify(title, message, priority);
        }
    };

    $.toaster.reset = function () {
        settings = {};
        $.extend(settings, defaults);
    };


    $('.synced-select-input').change(function () {
        console.log("Value of select has Changed!")
        var the_value = $(this).val();
        var the_id = $(this)[0].id;
        console.log("The id is " + the_id);
        var theTrigger = channel.trigger('client-update', {
            type: "select",
            id: the_id,
            contents: the_value
        });
        var the_input = $(this);
        var original_value = the_input.data('original-value');
        console.log(" Orginal Value is " + original_value + " Numeruc is " + the_numeric_value);
        if (+original_value == +the_numeric_value) {
            console.log("Adding the Class for orginal!");
            the_input.addClass("original-decision-value");
        } else {
            console.log("Romoving the class");
            the_input.removeClass("original-decision-value");
        }
    });

})(jQuery);

