﻿<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Ertist.About" %>



<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
    body{font-family: Arial;font-size: 10pt;}
    .main_menu{width: 100px; background-color: #fff;border: 1px solid #ccc !important; color: #000;text-align: center;height: 30px;line-height: 30px;margin-right: 5px;}
    .level_menu{width: 110px; background-color: #fff; color: #333;border: 1px solid #ccc !important;text-align: center;height: 30px;line-height: 30px;margin-top: 5px;}
    .selected{background-color: #9F9F9F;color: #fff;}
    input[type=text], input[type=password]{width: 200px;}
    table{border: 1px solid #ccc;}
    table th { background-color: #F7F7F7;color: #333;font-weight: bold;}
    table th, table td { padding: 5px; border-color: #ccc; }
    </style>

    <div style="margin-left:10%;">
        <h2>SiteMap</h2>
        
        <hr />
        <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" ShowStartingNode="false"
                SiteMapProvider="SiteMap" />
            <asp:Menu ID="Menu" runat="server" DataSourceID="SiteMapDataSource1" Orientation="Horizontal">
                <LevelMenuItemStyles>
                    <asp:MenuItemStyle CssClass="main_menu" />
                    <asp:MenuItemStyle CssClass="level_menu" />
                </LevelMenuItemStyles>
            </asp:Menu>
    </div>

</asp:Content>
