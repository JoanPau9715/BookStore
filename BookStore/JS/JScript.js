// scripts utiles y validaciones

var tempo = null;

function focoNombre() {

    document.getElementById("txtNombre").focus();
}

function focoNick() {

    document.getElementById("ctl00_body_txtlogNick").focus();
}

function registradoOK() {

    for (var i = 1; i <= 6; i++) {

        $("#divregistro" + i).fadeOut("slow");
    }

    tempo = setTimeout(gotoLogin, 500);

}

function gotoLogin() {

    window.location = 'login.aspx';
    
    clearTimeout(tempo);
}

function validarLogin() {

    var preloader = document.getElementById("preloader");
    var compruebeDatos = document.getElementById("ctl00_body_checkDatos");

    var validos = null;

    var nick = document.getElementById("ctl00_body_txtlogNick").value;
    var clave = document.getElementById("ctl00_body_txtlogClave").value;

    if ((nick == "") || (clave == "") || (/^\s+$/.test(nick)) || (/^\s+$/.test(clave))) {
        compruebeDatos.innerHTML = "compruebe sus datos";
        preloader.style.visibility = "hidden";        
        validos = false;
    }
    else {
        compruebeDatos.innerHTML = "";
        preloader.style.visibility = "visible";        
        validos = true;
    }

    return validos;    
}

function validaRegistro() { // falta validar email con expresion regular

    var valido = true;
    
    var txtNombre = document.getElementById("txtNombre");
    var txtApellidos = document.getElementById("txtApellidos");
    var txteMail = document.getElementById("txteMail");
    var txtNick = document.getElementById("txtNick");
    var txtContrasena = document.getElementById("txtContrasena");
    var txtConfirmar = document.getElementById("txtConfirmar");

    var lblNombre = document.getElementById("lblNombre");
    var lblApellidos = document.getElementById("lblApellidos");
    var lbleMail = document.getElementById("lbleMail");
    var lblNick = document.getElementById("lblNick");
    var lblContrasena = document.getElementById("lblContrasena");
    var lblConfirmar = document.getElementById("lblConfirmar");

    if ((txtNombre.value.length < 3) || (txtNombre.value.length > 20) || (/^\s+$/.test(txtNombre.value))) {
        lblNombre.style.color = "Red";
        valido = false;
    } else
        lblNombre.style.color = "#000";

    if ((txtApellidos.value.length < 3) || (txtApellidos.value.length > 40) || (/^\s+$/.test(txtApellidos))) {
        lblApellidos.style.color = "Red";
        valido = false;
    } else
        lblApellidos.style.color = "#000";

    if ((txteMail.value == "") || (txteMail.value.length > 40)) {
        lbleMail.style.color = "Red";
        valido = false;
    } else
        lbleMail.style.color = "#000";

    if ((txtNick.value.length == 0) || (txtNick.value.length < 4) || (txtNick.value.length > 20) || (/^\s+$/.test(txtNick.value))) {
        lblNick.style.color = "Red";
        valido = false;
    } else
        lblNick.style.color = "#000";

    if ((txtContrasena.value == "") || (txtContrasena.value.length > 20) || (txtContrasena.value.length < 4) || (/^\s+$/.test(txtContrasena.value))) {
        lblContrasena.style.color = "Red";
        valido = false;
    } else
        lblContrasena.style.color = "#000";

    if (txtConfirmar.value != txtContrasena.value) {
        lblConfirmar.style.color = "Red";
        valido = false;
    } else
        lblConfirmar.style.color = "#000";


    if (!interesMarcado()) {
        valido = false;
        mostrarTipi('seleccione algún interés');
    }
    else {
        if (!modoAvisoMarcado()) {
            valido = false;
            mostrarTipi('marque su preferencia');
        }
    }

    return valido;

}

function mostrarTipi(aviso) {

    document.getElementById("tipaviso").innerHTML = aviso;
    $("#tipi").fadeIn("slow");
    $("#tipaviso").fadeIn("slow");

    tempo = setTimeout(ocultarTipi, 3000);
}

function ocultarTipi() {

    $("#tipi").fadeOut("slow");
    $("#tipaviso").fadeOut("slow");
    clearTimeout(tempo);
}

function interesMarcado() {

    var marcado = false;

    var contador = 0;

    do {

        var casilla = document.getElementById("ctl00_body_listaGeneros_" + contador);

        if (casilla.checked) {

            marcado = true;

            break;
        }

        contador++;

    } while (document.getElementById("ctl00_body_listaGeneros_" + contador));

    return marcado;

}

function modoAvisoMarcado() {

    var marcado = false;
    
    var opcion1 = document.getElementById("ctl00_body_optionList_0");
    var opcion2 = document.getElementById("ctl00_body_optionList_1");

    marcado = ((opcion1.checked) || (opcion2.checked));

    return marcado;

}

function nombreOk() {

    document.getElementById("lblNombre").style.color = "#000";
}

function apellidosOk() {

    document.getElementById("lblApellidos").style.color = "#000";
}

function emailOk() {

    document.getElementById("lbleMail").style.color = "#000";
}

function nickOk() {

    document.getElementById("lblNick").style.color = "#000";
}

function availNick() {

    document.getElementById("spanNoNick").style.visibility = "hidden";
}

function contrasenaOk() {

    document.getElementById("lblContrasena").style.color = "#000";
}

function confirmarOk() {

    document.getElementById("lblConfirmar").style.color = "#000";
}