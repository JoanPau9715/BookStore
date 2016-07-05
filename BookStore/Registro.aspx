<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="Registro.aspx.cs" Inherits="Registro" Title="Book Store" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="divmarco">
        <div class="divcontenido">   
            <div id="divregistro1" class="divsregistro">
                <p>
                    <span id="lblNombre" class="etqs">Nombre</span>
                    <input id="txtNombre" type="text" class="edits" onkeyup="nombreOk()" />
                </p>
                <p>
                    <span id="lblApellidos" class="etqs">Apellidos</span>
                    <input id="txtApellidos" type="text" class="edits" onkeyup="apellidosOk()" />
                </p>                
                <p>
                    <span id="lbleMail" class="etqs">e mail</span>
                    <input id="txteMail" type="text" class="edits" onkeyup="emailOk()" />                    
                </p>                                
            </div>            
            
            <div id="divregistro2" class="divsregistro">
                <p>
                    <span id="lblNick" class="etqs">Nick</span>
                    <input id="txtNick" type="text" class="edits" onblur="comprobarNick()" onkeyup="nickOk()" onfocus="availNick()" />                    
                    <span id="spanNoNick" class="etqsno">nick no disponible</span>
                </p>
                <p>
                    <span id="lblContrasena" class="etqs">Contraseña</span>
                    <input id="txtContrasena" type="password" class="edits" onkeyup="contrasenaOk()" />                    
                </p>                
                <p>
                    <span id="lblConfirmar" class="etqs">Confirmar</span>
                    <input id="txtConfirmar" type="password" class="edits" onkeyup="confirmarOk()" />                    
                </p>                                
            </div> 
            
            <div id="divregistro3" class="divsregistro">
                <span>Deseo recibir información sobre las novedades de los siguientes géneros</span>            
                <br /><br />
                <asp:CheckBoxList CssClass="opcionesInfo" ID="listaGeneros" runat="server" RepeatColumns="4" 
                                  RepeatDirection="Horizontal" CellPadding="3" CellSpacing="3">
                </asp:CheckBoxList>
            </div>     

            <div id="divregistro4" class="divsregistro">            
                <span>Esta información quiero recibirla</span>
                <br /><br />
                <asp:RadioButtonList ID="optionList" runat="server">
                    <asp:ListItem>en mi correo electrónico</asp:ListItem>
                    <asp:ListItem>notificación a mi cuenta en Book Store</asp:ListItem>
                </asp:RadioButtonList>
            </div>                 

            <div id="divregistro5" class="divtipi">            
                <img id="tipi" src="images/tipi.png" alt="" class="tipi"/>                
                <span id="tipaviso" class="tipaviso"></span>                
            </div>                 
            
            <div id="divregistro6" class="divenvio">
                <input id="btnEnviar" type="button" value="Enviar" class="botones" onclick="registrarUsuario()" />    
                <img id="preloader" src="images/loader2.gif" alt="enviando..." class="loader" />
            </div>                  
            
        </div>
        <div class="divlateral">
        </div>
    </div>
</asp:Content>

