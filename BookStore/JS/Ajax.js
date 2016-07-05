// scripts para comunicaciones Ajax
// raw ajax


function verNuevosLibros(fechaDesde) {

    alert(fechaDesde);
}

function registrarUsuario() {

    var registroValido = validaRegistro();

    if (registroValido) {

        document.getElementById("btnEnviar").disabled = true;

        var nombre = document.getElementById("txtNombre").value;
        var apellidos = document.getElementById("txtApellidos").value;
        var email = document.getElementById("txteMail").value;
        var nick = document.getElementById("txtNick").value;
        var clave = document.getElementById("txtContrasena").value;
            
        var intereses = '';
        
        var contador = 0;

        do {

            var cadaInteres = '';
            var casilla = document.getElementById("ctl00_body_listaGeneros_" + contador);

            if (casilla.checked) {

                cadaInteres = casilla.parentNode.lastChild.firstChild.nodeValue;

                if (intereses != '')
                    intereses += '-';
                    
                intereses += cadaInteres;                
            }

            contador++;

        } while (document.getElementById("ctl00_body_listaGeneros_" + contador));

        var tipoAviso = '';

        var opcion = document.getElementById("ctl00_body_optionList_0");

        if (opcion.checked)
            tipoAviso = 'email';
        else
            tipoAviso = 'notificacion';
        
        var transport = getTransport();
        
        if (transport) {

            transport.open('POST', "ASPX/manageClient.aspx" + "?nocache=" + Math.random());
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                preloader = document.getElementById("preloader");

                if (transport.readyState != 4) {

                    preloader.style.visibility = "visible";
                }
                if ((transport.readyState == 4) && (transport.status == 200)) {

                    preloader.style.visibility = "hidden";

                    document.getElementById("btnEnviar").disabled = false;                    

                    var respuesta = transport.responseText;

                    if (respuesta.indexOf("todo bien") != -1)
                        registradoOK();                    
                    else if (respuesta.indexOf("nick no disponible") != -1)
                        document.getElementById("spanNoNick").style.visibility = "visible";
                    else if (respuesta.indexOf("email no disponible") != -1)
                        mostrarTipi("email no disponible");
                    else if (respuesta.indexOf("program error") != -1)
                        alert(respuesta);                    
                }
            };

            transport.send("accion=alta" + "&nombre=" + encodeURIComponent(nombre) + "&apellidos=" + encodeURIComponent(apellidos) +
                           "&email=" + encodeURIComponent(email) + "&nick=" + encodeURIComponent(nick) + "&clave=" +
                           encodeURIComponent(clave) + "&intereses=" + encodeURIComponent(intereses) + "&tipoaviso=" + 
                           encodeURIComponent(tipoAviso));
        }
    }
}


function comprobarNick() {

    var nick = document.getElementById("txtNick").value;


    var transport = getTransport();

    if (transport) {

        transport.open('POST', "ASPX/manageClient.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            if ((transport.readyState == 4) && (transport.status == 200)) {

                var respuesta = transport.responseText;

                var noNick = document.getElementById("spanNoNick");

                if (respuesta.indexOf("no") != -1)
                    noNick.style.visibility = "visible";
                else
                    noNick.style.visibility = "hidden";

            }
        };

        transport.send("accion=nickdisponible" + "&nick=" + encodeURIComponent(nick));
    }
}


function horaCliente() {

    var horaCli = new Date();
    var hora = horaCli.getHours();

    var transport = getTransport();

    if (transport) {

        transport.open('POST', "ASPX/horaGMT.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.send("hora=" + encodeURIComponent(hora));
    }    
}

function getTransport() {

    var transport = false;

    if (window.XMLHttpRequest) {
        transport = new XMLHttpRequest(); // Opera, Mozilla, IE7
    }
    else if (window.ActiveXObject) {
        try {
            transport = new ActiveXObject('Msxml2.XMLHTTP'); // IE 6
        }
        catch (err) {
            transport = new ActiveXObject('Microsoft.XMLHTTP'); // IE 5
        }
    }

    return (transport);
}
