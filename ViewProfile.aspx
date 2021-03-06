﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master"
    CodeFile="ViewProfile.aspx.cs" Inherits="ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="print_area" class="contents">
        <img src="images/title_SDetails.gif" />
        <p>
            <a href="Search.aspx">Return to Search Page</a></p>
        <asp:Menu runat="server" ID="menuTabs" Orientation="Horizontal" CssClass="menuTabs"
            OnMenuItemClick="menuTabs_MenuItemClick" ForeColor="#000" StaticHoverStyle-CssClass="hoverTab"
            StaticMenuItemStyle-ItemSpacing="3" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selectedTab">
            <Items>
                <asp:MenuItem Enabled="true" Text="Personal Information" Value="0" Selected="true">
                </asp:MenuItem>
            </Items>
        </asp:Menu>
        <div class="tabBody">
            <asp:MultiView ID="multiTabs" ActiveViewIndex="0" runat="server">
                <asp:View ID="PersonalView" runat="server">
                    <table width="100%">
                        <tr>
                            <td valign="top" width="50%">
                                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="UserProfileID"
                                    DataSourceID="SqlDataSource1" Width="100%" AllowPaging="true" CellPadding="4"
                                    GridLines="None">
                                    <FieldHeaderStyle Font-Bold="true" />
                                    <Fields>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <%# string.Format("{0} {1} {2} {3} ({4})", Eval("Salutation"), Eval("FirstName"), Eval("MiddleName"), Eval("LastName"), (Eval("PreferredName").ToString().Length==0?Eval("FirstName"):Eval("PreferredName")))%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Family Branch">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFamilyBranch" Text='<%# Eval("FamilyBranch") %>' runat="Server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Born On">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBornOn" Text='<%# string.Format("{0:MMM dd}", Eval("BornOn")) %>'
                                                    runat="Server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address" HeaderStyle-VerticalAlign="Top">
                                            <ItemTemplate>
                                                <%# string.Format("{0}, {1}, <br/>{2},{3}, {4}, {5}", Eval("Address1"), Eval("Address2"), Eval("City"), Eval("State"), Eval("Pincode"), Eval("Country"))%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="HomePhone" HeaderText="HomePhone" SortExpression="HomePhone" />
                                        <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" SortExpression="MobilePhone" />
                                        <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"
                                            ReadOnly="true" />
                                        <asp:BoundField DataField="AlternateEmailAddress" HeaderText="Alternate Email" SortExpression="AlternateEmailAddress" />
                                        <asp:BoundField DataField="Occupation" HeaderText="Occupation" SortExpression="Occupation" />
                                        <asp:BoundField DataField="Employer" HeaderText="Employer" SortExpression="Employer" />
                                        <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website" />
                                    </Fields>
                                </asp:DetailsView>
                            </td>
                            <td valign="top" width="50%">
                                <asp:Image ID="imgCropped" runat="server" src='<%# string.Format("Image.aspx?ID={0}",Request.Params["ID"])%>' Height="120px"
                                    Width="100px" /><br />
                                    <hr />
                                    <hr />
                                <asp:Repeater ID="rptrSpouse" runat="server" DataSourceID="SqlDataSourceSpouse">
                                    <HeaderTemplate>
                                        <b>Married to</b><br />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <a href="<%# string.Format("SProfile.aspx?ID={0}", Eval("SpID"))%>">
                                            <%# string.Format("{0} {1} {2} {3} ({4})", Eval("Salutation"), Eval("FirstName"), Eval("MiddleName"), Eval("LastName"), (Eval("PreferredName").ToString().Length==0?Eval("FirstName"):Eval("PreferredName")))%>
                                        </a>
                                        <br />
                                    </ItemTemplate>
                                </asp:Repeater>
                                <hr />
                                <asp:Repeater ID="rptrChild" runat="server" DataSourceID="SqlDataSourceChild" >
                                    <HeaderTemplate>
                                        <b>Children</b><br />
                                    </HeaderTemplate>
                               
                                    <ItemTemplate>
                                        <a href="<%# string.Format("ViewProfile.aspx?ID={0}", Eval("UserProfileID"))%>">
                                            <%# string.Format("{0} {1} {2} {3} ({4})", Eval("Salutation"), Eval("FirstName"), Eval("MiddleName"), Eval("LastName"), (Eval("PreferredName").ToString().Length==0?Eval("FirstName"):Eval("PreferredName")))%>
                                        </a>
                                        <br />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </td>
                            
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT  u.UserProfileID, u.Salutation, u.FirstName, u.MiddleName, u.LastName, u.PreferredName, u.FamilyBranch, u.HouseName, u.BornOn, u.MaritalStatus, u.Occupation, u.Employer, l.EmailAddress, u.AlternateEmailAddress, u.Address1, u.Address2, u.City, u.State, u.Pincode,u.Country, u.HomePhone, u.MobilePhone, u.Website  FROM tbluserprofile u left outer join tbluserlogin l on u.UserProfileID=l.UserProfileID WHERE (u.UserProfileID = ?) ">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="ID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSpouse" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT SpID, Salutation, FirstName, MiddleName, LastName, PreferredName, FamilyName, BornOn FROM tblSpouse WHERE (SpouseID = ?)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="ID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
                     <asp:SqlDataSource ID="SqlDataSourceChild" runat="server" ConnectionString="<%$ ConnectionStrings:KallivayalilDB %>"
                ProviderName="<%$ ConnectionStrings:KallivayalilDB.ProviderName %>" SelectCommand="SELECT  u.UserProfileID, u.Salutation, u.FirstName, u.MiddleName, u.LastName, u.PreferredName  FROM tbluserprofile u left outer join tbluserlogin l on u.UserProfileID=l.UserProfileID WHERE (u.ParentID = ?) ">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="ID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
