/*
 *
 *   INSPINIA - Responsive Admin Theme
 *   version 2.4
 *
 */
$(window).resize(function () {
    nonemenu();
});

function nonemenu() {
    var menu = $('.mini-navbar .lichildren.active');
    menu.removeClass('active');
    $('.nav-header .dropdown.profile-element').removeClass('active');
    $('.sidebar-left-secondary').removeClass('open');
}

$(document).click(function () {
    nonemenu();
    $('#menuexit').removeClass("showsesionmenu");
});

function EndCallbackUsers(params, answer) {
    if (!answer.Error) {
        $('#changePassword').modal("hide");
        toastr.success("Clave cambiada exitosamente. Debera ingresar nuevamente.", 'Sintesis ERP');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#btnSavepass').button('reset');
}

function EndCallbackHtmlGet(Parameter, Result) {
    if (!Result.error) {
        $('#BodyHtmlModal').html(Result.Message);
        $('#ModalHtml').modal({ backdrop: 'static', keyboard: false }, "show");
    }

    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}
$(document).ready(function () {

    $('#btnModal').click(function (e) {
        Parameter = {};
        Parameter.maestro = "Articulos";
        MethodHtml("Articulos", "ArticulosHtml", JSON.stringify(Parameter), "EndCallbackHtmlGet");
    })


    ReSizePage();
    $('#btnSavepass').click(function (e) {
        var JsonValidatePass = [{ id: 'actualpassword', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
        { id: 'newpassword', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
        { id: 'repitpassword', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }]
        if (validate(JsonValidatePass)) {
            var params = {};
            params.oldpass = $("#actualpassword").val();
            params.newpass = $('#newpassword').val();
            params.repitpassword = $('#repitpassword').val();
            if (params.newpass == params.repitpassword) {
                var btn = $(this);
                btn.button('loading');
                MethodService("Usuarios", "UsuarioChangePass", JSON.stringify(params), "EndCallbackUsers");
            }
            else
                toastr.error("Las claves nuevas no coinciden, Verifique.", 'Sintesis ERP');
        }
    });

    $('#changepass').click(function () {
        $("#actualpassword, #newpassword, #repitpassword").val('');
        $('#changePassword').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    var CURRENT_URL = window.location.href.split('#')[0].split('?')[0],
        $BODY = $('body'),
        $SIDEBAR_MENU = $('#side-menu');

    $SIDEBAR_MENU.find('.lichildren a').on('click', function (ev) {
        ev.stopPropagation();
        var $li = $(this).parent();

        var submenu = $('.sidebar-left-secondary');
        $('li.lichildren').not($li).removeClass('active');
        submenu.find('ul').removeClass('d-block').addClass('d-none');
        if ($li.is('.active')) {
            $li.removeClass('active active-sm');
            submenu.removeClass('open');
        } else {
            dataidmen = $(this).attr('data-id');
            submenu.find('#' + dataidmen).addClass('d-block').removeClass('d-none');
            $('.sidebar-left-secondary').addClass('open');
            $li.addClass('active');
        }
    });

    // Collapse ibox function
    $('.collapse-link').click(function () {
        var ibox = $(this).closest('div.ibox');
        var button = $(this).find('i');
        var content = ibox.find('div.ibox-content');
        content.slideToggle(200);
        button.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
        ibox.toggleClass('').toggleClass('border-bottom');
        setTimeout(function () {
            ibox.resize();
            ibox.find('[id^=map-]').resize();
        }, 50);
    });

    // Close ibox function
    $('.close-link').click(function () {
        var content = $(this).closest('div.ibox');
        content.remove();
    });

    // Fullscreen ibox function
    $('.fullscreen-link').click(function () {
        var ibox = $(this).closest('div.ibox');
        var button = $(this).find('i');
        $('body').toggleClass('fullscreen-ibox-mode');
        button.toggleClass('fa-expand').toggleClass('fa-compress');
        ibox.toggleClass('fullscreen');
        setTimeout(function () {
            $(window).trigger('resize');
        }, 100);
    });

    // Close menu in canvas mode
    $('.close-canvas-menu').click(function () {
        $("body").toggleClass("mini-navbar");
        SmoothlyMenu();
    });

    // Run menu of canvas
    $('body.canvas-menu .sidebar-collapse').slimScroll({
        height: '100%',
        railOpacity: 0.9
    });

    // Open close right sidebar
    $('.right-sidebar-toggle').click(function () {
        $('#right-sidebar').toggleClass('sidebar-open');
    });

    // Initialize slimscroll for right sidebar
    $('.sidebar-container').slimScroll({
        height: '100%',
        railOpacity: 0.4,
        wheelStep: 10
    });

    // Open close small chat
    $('.open-small-chat').click(function () {
        $(this).children().toggleClass('fa-comments').toggleClass('fa-remove');
        $('.small-chat-box').toggleClass('active');
    });

    // Initialize slimscroll for small chat
    $('.small-chat-box .content').slimScroll({
        height: '234px',
        railOpacity: 0.4
    });

    // Small todo handler
    $('.check-link').click(function () {
        var button = $(this).find('i');
        var label = $(this).next('span');
        button.toggleClass('fa-check-square').toggleClass('fa-square-o');
        label.toggleClass('todo-completed');
        return false;
    });

    // Append config box / Only for demo purpose
    // Uncomment on server mode to enable XHR calls
    //$.get("skin-config.html", function (data) {
    //    if (!$('body').hasClass('no-skin-config'))
    //        $('body').append(data);
    //});

    // Minimalize menu
    $('.menu-toggle').click(function () {
        $("body").toggleClass("mini");
        //SmoothlyMenu();
        //nonemenu();
    });

    $('#dropdowntoggle_').click(function () {//Este es la foto del usuario
        if ($("#menuexit2").css('display') !== 'none') {
            $("#menuexit2").toggleClass("showsesionmenu");
            $("#menuexit").toggleClass("showsesionmenu");
        } else {
            $("#menuexit").toggleClass("showsesionmenu");
        }
    });

    $('#dropdown-2').click(function (e) {//Esta es la campana de notificaciones
        if ($('#menuexit').css('display') !== 'none') {
            $('#menuexit').toggleClass("showsesionmenu");
            $("#menuexit2").toggleClass("showsesionmenu");
        } else {
            $("#menuexit2").toggleClass("showsesionmenu");
        }
    }); 

    $('.handle').click(function () {
        $("#customizer").toggleClass("open");
        //SmoothlyMenu();
        //nonemenu();
    });

    // Tooltips demo
    $('.tooltip-demo').tooltip({
        selector: "[data-toggle=tooltip]",
        container: "body"
    });

    // Move modal to body
    // Fix Bootstrap backdrop issu with animation.css
    $('.modal').appendTo("body");

    // Full height of sidebar
    function fix_height() {
        var heightWithoutNavbar = $("body > #wrapper").height() - 61;
        $(".sidebard-panel").css("min-height", heightWithoutNavbar + "px");

        var navbarHeigh = $('nav.navbar-default').height();
        var wrapperHeigh = $('#page-wrapper').height();

        if (navbarHeigh > wrapperHeigh) {
            $('#page-wrapper').css("min-height", navbarHeigh + "px");
        }

        if (navbarHeigh < wrapperHeigh) {
            $('#page-wrapper').css("min-height", $(window).height() + "px");
        }

        if ($('body').hasClass('fixed-nav')) {
            if (navbarHeigh > wrapperHeigh) {
                $('#page-wrapper').css("min-height", navbarHeigh - 60 + "px");
            } else {
                $('#page-wrapper').css("min-height", $(window).height() - 60 + "px");
            }
        }

    }

    fix_height();

    // Fixed Sidebar
    $(window).bind("load", function () {
        if ($("body").hasClass('fixed-sidebar')) {
            $('.sidebar-collapse').slimScroll({
                height: '100%',
                railOpacity: 0.9
            });
        }

    });


    // Move right sidebar top after scroll
    $(window).scroll(function () {
        if ($(window).scrollTop() > 0 && !$('body').hasClass('fixed-nav')) {
            $('#right-sidebar').addClass('sidebar-top');
        } else {
            $('#right-sidebar').removeClass('sidebar-top');
        }
    });

    $(window).bind("load resize scroll", function () {
        if (!$("body").hasClass('body-small')) {
            fix_height();
        }

    });

    $("[data-toggle=popover]")
        .popover();

    // Add slimscroll to element
    $('.full-height-scroll').slimscroll({
        height: '100%'
    })
});

// Minimalize menu when screen is less than 768px
$(window).bind("resize", function () {
    ReSizePage();

});

function ReSizePage() {
    if ($(this).width() < 800) {
        $('body').addClass('mini')
    } else {
        $('body').removeClass('mini')
    }
    var hiegthbody = $(document).height();
    $('#rowPage').css({ 'height': (hiegthbody - 61) })
}
// Local Storage functions
// Set proper body class and plugins based on user configuration
$(document).ready(function () {
    if (localStorageSupport) {

        var collapse = localStorage.getItem("collapse_menu");
        var fixedsidebar = localStorage.getItem("fixedsidebar");
        var fixednavbar = localStorage.getItem("fixednavbar");
        var boxedlayout = localStorage.getItem("boxedlayout");
        var fixedfooter = localStorage.getItem("fixedfooter");

        var body = $('body');

        if (fixedsidebar == 'on') {
            body.addClass('fixed-sidebar');
            $('.sidebar-collapse').slimScroll({
                height: '100%',
                railOpacity: 0.9
            });
        }

        if (collapse == 'on') {
            if (body.hasClass('fixed-sidebar')) {
                if (!body.hasClass('body-small')) {
                    body.addClass('mini-navbar');
                }
            } else {
                if (!body.hasClass('body-small')) {
                    body.addClass('mini-navbar');
                }

            }
        }

        if (fixednavbar == 'on') {
            $(".navbar-static-top").removeClass('navbar-static-top').addClass('navbar-fixed-top');
            body.addClass('fixed-nav');
        }

        if (boxedlayout == 'on') {
            body.addClass('boxed-layout');
        }

        if (fixedfooter == 'on') {
            $(".footer").addClass('fixed');
        }
    }
});

// check if browser support HTML5 local storage
function localStorageSupport() {
    return (('localStorage' in window) && window['localStorage'] !== null)
}

// For demo purpose - animation css script
function animationHover(element, animation) {
    element = $(element);
    element.hover(
        function () {
            element.addClass('animated ' + animation);
        },
        function () {
            //wait for animation to finish before removing classes
            window.setTimeout(function () {
                element.removeClass('animated ' + animation);
            }, 2000);
        });
}

function SmoothlyMenu() {
    if (!$('body').hasClass('mini-navbar') || $('body').hasClass('body-small')) {
        // Hide menu in order to smoothly turn on when maximize menu
        $('#side-menu').hide();
        // For smoothly turn on menu
        setTimeout(
            function () {
                $('#side-menu').fadeIn(400);
            }, 200);
    } else if ($('body').hasClass('fixed-sidebar')) {
        $('#side-menu').hide();
        setTimeout(
            function () {
                $('#side-menu').fadeIn(400);
            }, 100);
    } else {
        // Remove all inline style from jquery fadeIn function to reset menu state
        $('#side-menu').removeAttr('style');
    }
}

// Dragable panels
function WinMove() {
    var element = "[class*=col]";
    var handle = ".ibox-title";
    var connect = "[class*=col]";
    $(element).sortable(
        {
            handle: handle,
            connectWith: connect,
            tolerance: 'pointer',
            forcePlaceholderSize: true,
            opacity: 0.8
        })
        .disableSelection();
}


