<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="HotelPGProject.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hotel/PG Registration</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .form-container { width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: bold; }
        .form-group input[type="text"], input[type="date"], input[type="file"] { width: 100%; padding: 8px; }
        .error { color: red; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>User Registration Form</h2>
            
            <!-- User Details -->
            <div class="form-group">
                <label for="txtUserName">User Name:</label>
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName" ErrorMessage="User Name is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtPhoneNumber">Phone Number:</label>
                <asp:TextBox ID="txtPhoneNumber" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Phone Number is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtAddress">Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtIdType">ID Type:</label>
                <asp:TextBox ID="txtIdType" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvIdType" runat="server" ControlToValidate="txtIdType" ErrorMessage="ID Type is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtRelation">Relation:</label>
                <asp:TextBox ID="txtRelation" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRelation" runat="server" ControlToValidate="txtRelation" ErrorMessage="Relation is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtRelationMobile">Relation Mobile Number:</label>
                <asp:TextBox ID="txtRelationMobile" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRelationMobile" runat="server" ControlToValidate="txtRelationMobile" ErrorMessage="Relation Mobile Number is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <!-- Room Details -->
            <h3>Room Details</h3>
            <div class="form-group">
                <label for="txtFloor">Floor:</label>
                <asp:TextBox ID="txtFloor" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFloor" runat="server" ControlToValidate="txtFloor" ErrorMessage="Floor is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtBlock">Block:</label>
                <asp:TextBox ID="txtBlock" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBlock" runat="server" ControlToValidate="txtBlock" ErrorMessage="Block is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtRoom">Room:</label>
                <asp:TextBox ID="txtRoom" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRoom" runat="server" ControlToValidate="txtRoom" ErrorMessage="Room is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtBed">Bed:</label>
                <asp:TextBox ID="txtBed" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBed" runat="server" ControlToValidate="txtBed" ErrorMessage="Bed is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtRentAmount">Rent Amount:</label>
                <asp:TextBox ID="txtRentAmount" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRentAmount" runat="server" ControlToValidate="txtRentAmount" ErrorMessage="Rent Amount is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revRentAmount" runat="server" ControlToValidate="txtRentAmount" ErrorMessage="Invalid Rent Amount" ValidationExpression="^\d+(\.\d{1,2})?$" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>
            
            <!-- Financial Details -->
            <h3>Financial Details</h3>
            <div class="form-group">
                <label for="txtAdvance">Advance:</label>
                <asp:TextBox ID="txtAdvance" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAdvance" runat="server" ControlToValidate="txtAdvance" ErrorMessage="Advance is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revAdvance" runat="server" ControlToValidate="txtAdvance" ErrorMessage="Invalid Advance" ValidationExpression="^\d+(\.\d{1,2})?$" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>
            
            <div class="form-group">
                <label for="txtDiscount">Discount:</label>
                <asp:TextBox ID="txtDiscount" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDiscount" runat="server" ControlToValidate="txtDiscount" ErrorMessage="Discount is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revDiscount" runat="server" ControlToValidate="txtDiscount" ErrorMessage="Invalid Discount" ValidationExpression="^\d+(\.\d{1,2})?$" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>
            
            <div class="form-group">
                <label for="txtDamageCharge">Damage Charge:</label>
                <asp:TextBox ID="txtDamageCharge" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDamageCharge" runat="server" ControlToValidate="txtDamageCharge" ErrorMessage="Damage Charge is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revDamageCharge" runat="server" ControlToValidate="txtDamageCharge" ErrorMessage="Invalid Damage Charge" ValidationExpression="^\d+(\.\d{1,2})?$" CssClass="error" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>
            
            <div class="form-group">
                <label for="txtJoiningDate">Joining Date:</label>
                <asp:TextBox ID="txtJoiningDate" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvJoiningDate" runat="server" ControlToValidate="txtJoiningDate" ErrorMessage="Joining Date is required" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            
            <!-- Files -->
            <h3>Upload Files</h3>
            <div class="form-group">
                <label for="fuIdProof">ID Proof Image:</label>
                <asp:FileUpload ID="fuIdProof" runat="server" />
            </div>
            
            <div class="form-group">
                <label for="fuUserPhoto">User Photo:</label>
                <asp:FileUpload ID="fuUserPhoto" runat="server" />
            </div>
            
            <asp:Button ID="btnSubmit" runat="server" Text="Register" OnClick="btnSubmit_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="error"></asp:Label>
        </div>
    </form>
</body>
</html>