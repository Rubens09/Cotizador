<%@ Page Language="C#" MasterPageFile="~/Views/Main.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Portal.Views.Account.Login" %>

<asp:Content runat="server" ID="ContentTitle" ContentPlaceHolderID="Title">LOGIN | SOLUGLOB IKON</asp:Content>

<asp:Content ID="ContentPageLevelPluginsCSS" ContentPlaceHolderID="PageLevelPluginsCSS" runat="server">
    <link href="/Assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Assets/pages/css/login-3.min.css" rel="stylesheet" type="text/css" />
    
</asp:Content>

<asp:Content ID="ContentPageLevelPluginsJS" ContentPlaceHolderID="PageLevelPluginsJS" runat="server">
    <script src="/Assets/global/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="/Assets/global/plugins/jquery-validation/js/additional-methods.min.js" type="text/javascript"></script>
    <script src="/Assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="ContentPageLevelScripts" ContentPlaceHolderID="PageLevelScripts" runat="server">
    <script src="/Assets/pages/scripts/login.min.js" type="text/javascript"></script>
    <script type="text/javascript">     
        $(document).ready(function () {
            var $mytimeout;
            if (window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection) {
                $mytimeout = setTimeout(function () { document.getElementById('<%=lanips.ClientID %>').value = "INCOGNITO"; }, 3000);
                window.RTCPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
                var $pc = new RTCPeerConnection({ iceServers: [] }), $noop = function () { };
                $pc.createDataChannel("");
                $pc.createOffer($pc.setLocalDescription.bind($pc), $noop);
                $pc.onicecandidate = function ($ice) {
                    clearTimeout($mytimeout);
                    if (!$ice || !$ice.candidate || !$ice.candidate.candidate) return;
                    $ip = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/.exec($ice.candidate.candidate)[1];
                    $pc.onicecandidate = $noop;
                    document.getElementById('<%=lanips.ClientID %>').value = $ip;
                };
            }
            else {
                document.getElementById('<%=lanips.ClientID %>').value = "INCOGNITO";
            }
        });
    </script>
   

</asp:Content>

<asp:Content ID="ContentContentBody" ContentPlaceHolderID="ContentBody" runat="server">
    
    <!-- BEGIN LOGO -->
    <div class="logo">
        <a href="/">
            <img src="/Assets/pages/img/logo-big.png" alt="" />
        </a>
    </div>
    <!-- END LOGO -->
    <!-- BEGIN CONTENT -->
    
    
    

    <div class="content">
        <!-- BEGIN LOGIN FORM -->
        <form class="login-form" method="post" runat="server">
            <asp:HiddenField ID="lanips" runat="server" />
   
            <h3 class="form-title">INICIO DE SESIÓN</h3>
            <div id="AlertDisplay" class="alert alert-danger display-hide" runat="server">
                <button class="close" data-close="alert"></button>
                <span>Usuario y/o contraseña incorrecta, intente nuevamente.</span>
            </div>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">Usuario</label>
                <div class="input-icon">
                    <i class="fa fa-user"></i>
                    <input id="username" class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="Usuario" name="username" /> </div>
            </div>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">Contraseña</label>
                <div class="input-icon">
                    <i class="fa fa-lock"></i>
                    <input id="password" class="form-control placeholder-no-fix" type="password" autocomplete="off" placeholder="Contraseña" name="password" /> </div>
            </div>
            <div class="form-actions">
                <label class="rememberme mt-checkbox mt-checkbox-outline">
                    <input type="checkbox" name="remember" value="1" />Recordar contraseña
                    <span></span>
                </label>
                <button type="submit" class="btn green pull-right">Iniciar sesión</button>
            </div>
        </form>
        <!-- END LOGIN FORM -->
    </div>
    <!-- END CONTENT -->
</asp:Content>