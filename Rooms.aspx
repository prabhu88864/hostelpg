<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rooms.aspx.cs" Inherits="Hostelpg.Rooms" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rooms Management</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }
        .form-container { width: 750px; margin: 30px auto; padding: 25px; background: white; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
        .form-group input[type="text"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .error { color: red; font-size: 0.9em; }
        .grid { margin-top: 30px; width: 100%; border-collapse: collapse; }
        .grid th { background-color: #007bff; color: white; padding: 12px; }
        .grid td { padding: 10px; border: 1px solid #ddd; }
        .btn { padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #218838; }
        .status-available { color: green; font-weight: bold; }
        .status-occupied { color: red; font-weight: bold; }
        .message { margin: 20px 0; font-size: 1.1em; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Manage Rooms and Beds</h2>

            <!-- Add New Bed Form -->
            <h3>Add New Bed</h3>
            <p>You can add unlimited beds per room. Each bed has its own status.</p>

            <div class="form-group">
                <label>Floor</label>
                <asp:TextBox ID="txtFloor" runat="server" placeholder="e.g., Ground, First"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFloor" runat="server" ControlToValidate="txtFloor"
                    ErrorMessage="Floor is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label>Block</label>
                <asp:TextBox ID="txtBlock" runat="server" placeholder="e.g., A, B"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBlock" runat="server" ControlToValidate="txtBlock"
                    ErrorMessage="Block is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label>Room No.</label>
                <asp:TextBox ID="txtRoom" runat="server" placeholder="e.g., 101, 202"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRoom" runat="server" ControlToValidate="txtRoom"
                    ErrorMessage="Room is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label>Bed Name</label>
                <asp:TextBox ID="txtBed" runat="server" placeholder="e.g., Bed 1, Lower, A"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBed" runat="server" ControlToValidate="txtBed"
                    ErrorMessage="Bed name is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label>Rent Amount</label>
                <asp:TextBox ID="txtRentAmount" runat="server" placeholder="e.g., 5000"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRentAmount" runat="server" ControlToValidate="txtRentAmount"
                    ErrorMessage="Rent Amount is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revRentAmount" runat="server" ControlToValidate="txtRentAmount"
                    ErrorMessage="Invalid amount" ValidationExpression="^\d+(\.\d{1,2})?$" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <asp:Button ID="btnAdd" runat="server" Text="Add Bed" OnClick="btnAdd_Click" CssClass="btn" />
            
            <div class="message">
                <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
            </div>

            <!-- GridView - List of Beds -->
            <h3>All Beds (Individual Status)</h3>
            <asp:GridView ID="gvRooms" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                OnRowEditing="gvRooms_RowEditing"
                OnRowCancelingEdit="gvRooms_RowCancelingEdit"
                OnRowUpdating="gvRooms_RowUpdating"
                OnRowDeleting="gvRooms_RowDeleting"
                CssClass="grid" AllowPaging="True" PageSize="15">

                <Columns>
                    <asp:TemplateField HeaderText="Floor">
                        <ItemTemplate><%# Eval("Floor") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFloorEdit" runat="server" Text='<%# Bind("Floor") %>' Width="90px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Block">
                        <ItemTemplate><%# Eval("Block") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtBlockEdit" runat="server" Text='<%# Bind("Block") %>' Width="70px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Room">
                        <ItemTemplate><%# Eval("Room") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtRoomEdit" runat="server" Text='<%# Bind("Room") %>' Width="80px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Bed">
                        <ItemTemplate><%# Eval("Bed") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtBedEdit" runat="server" Text='<%# Bind("Bed") %>' Width="100px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Rent (₹)">
                        <ItemTemplate><%# Eval("RentAmount") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtRentEdit" runat="server" Text='<%# Bind("RentAmount") %>' Width="90px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Eval("Status").ToString() == "Available" ? "status-available" : "status-occupied" %>'>
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatusEdit" runat="server" SelectedValue='<%# Bind("Status") %>'>
                                <asp:ListItem>Available</asp:ListItem>
                                <asp:ListItem>Occupied</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Button" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>