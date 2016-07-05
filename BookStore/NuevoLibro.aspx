<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="NuevoLibro.aspx.cs" Inherits="Inicio" Title="Book Store" %>
<%@ MasterType TypeName="Principal" %>
<%@ Register Assembly="FUA" Namespace="Subgurim.Controles" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="divmarco">
        <div class="divcontenido">
            <cc1:FileUploaderAJAX ID="FileUploaderAJAX1" runat="server" File_RenameIfAlreadyExists="True" 
            text_Add="Añadir portada" text_Uploading="Subiendo..." CssClass="uploader" />             
        </div>
        <div class="divlateral">
        </div>
    </div>
</asp:Content>

