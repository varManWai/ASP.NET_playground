﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Ertist.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" href="./css/Payment.css">

    <section class="cart_section">
        <div class="page_header">
            <h1>Payment</h1>
        </div>


        <div class="cart_all">
            <div class="makeOrder_container_all">
                <div class="artwork_container_all">
                    <div class="address">
                        <span>Address</span>
                    </div>
                    <div class="address_container">
                        <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ertistDB %>" SelectCommand="SELECT * FROM Address WHERE (userID = @UserID) AND (addressName = @addressName)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="UserID" />

                                <asp:QueryStringParameter Name="addressName" QueryStringField="Address" />

                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Repeater ID="Repeater6" runat="server" DataSourceID="SqlDataSource6">
                            <ItemTemplate>
                                <div style="display:none">
                                    <%# Session["addressID"] = Convert.ToInt32(Eval("addressID")) %>
                                </div>
                                <div class="address_name">
                                    <asp:Label ID="lblAddressName" runat="server" Text=""> <%# Eval("addressName") %></asp:Label>
                                </div>
                                <div class="address_detail">
                                    <asp:Label ID="lblAddress" runat="server" Text=""> <%# Eval("address")%> &nbsp<%# Eval("postcode") %> &nbsp<%# Eval("state")%>&nbsp <%# Eval("city")%> </asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="total_artwork_cart">
                        <span>Order Product</span>
                    </div>
                    <div class="artworks_container_all">
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ertistDB %>" SelectCommand="SELECT [User].UserID,[User].email, [User].username, [User].picture, Cart.userID AS UserID2, Cart.artworkID, Artwork.artworkID AS ArtworkID2, Artwork.price, Artwork.name, Artwork.picture AS picture2, Artwork.description FROM [User] INNER JOIN Cart ON [User].UserID = Cart.userID INNER JOIN Artwork ON Cart.artworkID = Artwork.artworkID WHERE ([User].UserID = @UserID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="UserID" />
                            </SelectParameters>
                        </asp:SqlDataSource>



                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource2">
                            <ItemTemplate>
                                <div style="display: none">
                                    <%# Session["email"] = Eval("email") %>
                                </div>

                                <div class="artwork_container">
                                    <div class="artwork_image">
                                        <img src="<%# GetImage(Eval("picture2")) %>" alt="An Artwork Picture">
                                    </div>
                                    <div class="artwork_details" style="width: 614px;">
                                        <span class="artwor_details_name"><%# Eval("name") %></span>
                                        <div class="artist">
                                            <img src="<%# GetImage(Eval("picture")) %>" alt="An Artist Picture">
                                            <span><%# Session["username"] = Eval("username") %></span>
                                        </div>
                                        <div class="artwork_description">
                                            <%# Eval("description") %>
                                        </div>
                                        <div class="price_remove">
                                            <span class="price">$<%# Eval("price") %></span></div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                </div>

                <aside class="summary">
                    <h2>Summary</h2>
                    <div class="artwork_each_price">
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ertistDB %>" SelectCommand="SELECT Artwork.price, Artwork.name FROM [User] INNER JOIN Cart ON [User].UserID = Cart.userID INNER JOIN Artwork ON Cart.artworkID = Artwork.artworkID WHERE ([User].UserID = @UserID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserID" SessionField="UserID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource3">
                            <ItemTemplate>
                                <div class="each_artwork">
                                    <div class="artwork_quantity">
                                        <div class="quantity">1x</div>
                                        <div class="summary_artwork_name">
                                            <%# Eval("name") %>
                                        </div>
                                    </div>
                                    <div class="summary_each_price">
                                        $<%# Eval("price") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>


                    </div>
                    <div class="total_price">
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString='<%$ ConnectionStrings:ertistDB %>' SelectCommand="SELECT SUM(Artwork.price) AS Expr1 FROM Artwork INNER JOIN Cart ON Artwork.artworkID = Cart.artworkID INNER JOIN [User] ON Cart.userID = [User].UserID WHERE ([User].UserID = @userID)">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="UserID" Name="userID"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Repeater ID="Repeater3" DataSourceID="SqlDataSource4" runat="server">
                            <ItemTemplate>
                                <div>
                                    Total: <span style="padding-right: 10px">$<%# Session["payment"] = Eval("Expr1") %></span></div>
                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                    <div class="checkout_button_container">
                        <!-- Set up a container element for the button -->
                        <div id="paypal-button-container"></div>
                    </div>
                </aside>

            </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    </section>

    <!-- Include the PayPal JavaScript SDK -->
    <script
        src="https://www.paypal.com/sdk/js?client-id=AW6etbpDGUmFpY-iA9-r3wXXmd2nDHo6PwCKP734surDr3TIqspck31udHgAXjKaUakbTysCiI7TB0Jz&currency=USD"></script>




    <script>

        const total = <%= Session["payment"].ToString() %>

            console.log(total);
            console.log(total);


        // Render the PayPal button into #paypal-button-container
        paypal.Buttons({

            style: {
                color: 'blue',
                shape: 'pill',
                label: 'pay',
                height: 40
            },

            // Set up the transaction
            createOrder: function (data, actions) {
                return actions.order.create({
                    purchase_units: [{
                        amount: {
                            value: total
                        }
                    }]
                });
            },

            // Finalize the transaction
            onApprove: function (data, actions) {
                return actions.order.capture().then(function (orderData) {
                    // Successful capture! For demo purposes:
                    //console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
                    //var transaction = orderData.purchase_units[0].payments.captures[0];
                    //alert('Transaction ' + transaction.status + ': ' + transaction.id + '\n\nSee console for all available details');

                    // Replace the above to show a success message within this page, e.g.




                    const element = document.getElementById('paypal-button-container');

                    console.log("laimanwai");
                    
                    


                    /*element.innerHTML = '';
                    element.innerHTML = '<h3>Thank you for your payment!</h3>';*/
                    //Or go to another URL:  
                    <%--<% Response.Redirect(url: "OrderSuccess"); %>--%>
                    window.location.replace("OrderSuccess");
                });
            }


        }).render('#paypal-button-container');
    </script>



</asp:Content>
