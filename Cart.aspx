﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Ertist.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">





    <link rel="stylesheet" href="./css/Cart.css">




    <section class="cart_section">
        <div class="page_header">
            <h1>Shopping Cart</h1>
        </div>

        <% if (Session["UserID"] == null)
            {

        %>
        <div style="display: flex; justify-content: center; align-items: center;">
            <div style="font-size: 50px; padding-top: 50px">Please login first</div>
        </div>




        <% 
            }
            else
            {
        %>

        <div class="cart_all">
            <div class="artwork_container_all">
                <div class="total_artwork_cart">
                    <span>Artworks in Cart</span>
                </div>

                <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="rpt2_ItemDataBound">
                    <ItemTemplate>
                        <div class="artwork_container">
                            <asp:HiddenField ID="hdfUserId" runat="server" Value='<%# Eval("artworkID") %>' />
                            <div class="artwork_image">
                                <img src="<%# GetImage(Eval("picture")) %>" alt="">
                            </div>
                            <div class="artwork_details" style="width: 614px; height: 302px;">
                                <span class="artwor_details_name"><%# Eval("name") %></span>
                                <div class="artist">
                                    <asp:Repeater ID="Repeater3" runat="server">
                                        <ItemTemplate>
                                            <img src="<%# GetImage(Eval("picture")) %>" alt="">
                                            <span><%# Eval("username") %></span>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <div class="artwork_description">
                                    <%# Eval("description") %>
                                </div>

                                <div class="price_remove">
                                    <span class="price">$<%# Eval("price") %></span><asp:Button ID="btnRemove" OnClick="btnRemove_Click" runat="server" CustomParameter='<%# Eval("cartID") %>' Text="Remove" Style="background-color: #ca3f49; outline: none; border: none; border-radius: 300px; width: 100%; max-width: 158px; height: 38px; color: white; font-size: clamp(10px, 1.5vw, 15px); margin-left: 20px; letter-spacing: 0.12em;" />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>


            <aside class="summary">
                <%--<h2>Summarysummary">--%>
                <h2>Summary</h2>
                <div class="artwork_each_price">

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ertistDB %>' SelectCommand="SELECT Artwork.artworkID, Artwork.name, Artwork.price, Artwork.description, Artwork.picture, Artwork.date, Artwork.stock, Artwork.available, Artwork.categoryID, Artwork.galleryID, [User].picture AS Expr1, [User].username, Cart.cartID FROM Artwork INNER JOIN Cart ON Artwork.artworkID = Cart.artworkID INNER JOIN [User] ON Cart.userID = [User].UserID WHERE ([User].UserID = @userID)">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="UserID" Name="userID"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource1">
                        <ItemTemplate>
                            <div class="each_artwork">
                                <div class="artwork_quantity">
                                    <div class="quantity">1x</div>
                                    <div class="summary_artwork_name">
                                        <%# Eval("name") %>
                                    </div>
                                </div>
                                <div class="summary_each_price">
                                    $<%# Eval("price") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>

                <div class="total_price" style="display: flex; flex-direction: column; border-top: 2px grey solid; margin-top: 20px">
                    <div style="display: flex; flex-direction: row; justify-content: space-between; font-size: 18px;">
                        Shipping Fee: <span style="padding-right: 10px; font-size: 18px; color: black; font-weight: 500; text-align: right;">$4.99</span>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:ertistDB %>' SelectCommand="SELECT SUM(Artwork.price) AS Expr1 FROM Artwork INNER JOIN Cart ON Artwork.artworkID = Cart.artworkID INNER JOIN [User] ON Cart.userID = [User].UserID WHERE ([User].UserID = @userID)">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="UserID" Name="userID"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>



                            <div style="display: flex; flex-direction: row; justify-content: space-between; font-size: 18px;">
                                Subtotal: <span style="padding-right: 10px; color: black; font-weight: 500; font-size: 18px;">$<%# Eval("Expr1") %></span>
                            </div>
                            <div style="display: flex; flex-direction: row; justify-content: space-between; font-weight: 700; border-top: 2px grey solid; margin-top: 10px; padding: 10px 0px">
                                Total: <span style="padding-right: 10px; color: black; font-weight: 700;">$<%# getTotal(Eval("Expr1"))  %></span>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="checkout_button_container">
                    <a href="./MakeOrder.aspx" class="checkout_button" style="text-decoration: none; display: flex; justify-content: center; align-items: center;">Checkout</a>
                </div>

            </aside>
        </div>
    </section>

    <%}
    %>
</asp:Content>
