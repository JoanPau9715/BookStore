<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" Title="Book Store" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
     <div class="divmarco">
         <div class="divcontenido">
             <div id="divlogin" class="divlogeo">
                 <p>
                     <span id="logNick" class="etqs">Nick</span>
                     <asp:TextBox ID="txtlogNick" runat="server" CssClass="edits"></asp:TextBox>
                 </p>
                 <p>
                     <span id="Span2" class="etqs">Contraseña</span>
                     <asp:TextBox ID="txtlogClave" runat="server" CssClass="edits" 
                         TextMode="Password"></asp:TextBox>
                 </p>                                
                 <br />
                 <asp:Button ID="btnAcceder" runat="server" Text="Acceder" CssClass="botones" 
                     onclick="btnAcceder_Click" OnClientClick="return validarLogin();" />
                 <asp:Label ID="checkDatos" CssClass="etqsnologin" runat="server" Text=""></asp:Label> 
             </div> 
             <div id="divloader" class="divloader">
                <p>
                    <img id="preloader" src="images/loader2.gif" alt="enviando..." class="loader" />                
                </p>
             </div>   
             <div id="divolvido">
                <a href="javascript:void(0)">¿Ha olvidado su contraseña?</a>
             </div>                 
         </div>
         <div class="divlateral">
         </div>
     </div>
</asp:Content>

