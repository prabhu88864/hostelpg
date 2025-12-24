using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace HotelPGProject
{
    public partial class Registration : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;
            if (Page.IsValid)
            {
                try
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["HotelPGDBConnectionString"].ConnectionString;
                    string idProofPath = string.Empty;
                    string userPhotoPath = string.Empty;

                    // Handle file uploads
                    string uploadFolder = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(uploadFolder))
                    {
                        Directory.CreateDirectory(uploadFolder);
                    }

                    if (fuIdProof.HasFile)
                    {
                        idProofPath = "~/Uploads/" + Guid.NewGuid().ToString() + Path.GetExtension(fuIdProof.FileName);
                        fuIdProof.SaveAs(Server.MapPath(idProofPath));
                    }

                    if (fuUserPhoto.HasFile)
                    {
                        userPhotoPath = "~/Uploads/" + Guid.NewGuid().ToString() + Path.GetExtension(fuUserPhoto.FileName);
                        fuUserPhoto.SaveAs(Server.MapPath(userPhotoPath));
                    }

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = @"INSERT INTO PGUsers (UserName, PhoneNumber, Address, IdType, Relation, RelationMobileNumber, 
                                         Floor, Block, Room, Bed, RentAmount, Advance, Discount, DamageCharge, JoiningDate, 
                                         IdProofImage, UserPhoto)
                                         VALUES (@UserName, @PhoneNumber, @Address, @IdType, @Relation, @RelationMobileNumber, 
                                         @Floor, @Block, @Room, @Bed, @RentAmount, @Advance, @Discount, @DamageCharge, @JoiningDate, 
                                         @IdProofImage, @UserPhoto)";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserName", txtUserName.Text.Trim());
                            cmd.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text.Trim());
                            cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                            cmd.Parameters.AddWithValue("@IdType", txtIdType.Text.Trim());
                            cmd.Parameters.AddWithValue("@Relation", txtRelation.Text.Trim());
                            cmd.Parameters.AddWithValue("@RelationMobileNumber", txtRelationMobile.Text.Trim());
                            cmd.Parameters.AddWithValue("@Floor", txtFloor.Text.Trim());
                            cmd.Parameters.AddWithValue("@Block", txtBlock.Text.Trim());
                            cmd.Parameters.AddWithValue("@Room", txtRoom.Text.Trim());
                            cmd.Parameters.AddWithValue("@Bed", txtBed.Text.Trim());
                            cmd.Parameters.AddWithValue("@RentAmount", decimal.Parse(txtRentAmount.Text.Trim()));
                            cmd.Parameters.AddWithValue("@Advance", decimal.Parse(txtAdvance.Text.Trim()));
                            cmd.Parameters.AddWithValue("@Discount", decimal.Parse(txtDiscount.Text.Trim()));
                            cmd.Parameters.AddWithValue("@DamageCharge", decimal.Parse(txtDamageCharge.Text.Trim()));
                            cmd.Parameters.AddWithValue("@JoiningDate", DateTime.Parse(txtJoiningDate.Text.Trim()));
                            cmd.Parameters.AddWithValue("@IdProofImage", string.IsNullOrEmpty(idProofPath) ? (object)DBNull.Value : idProofPath);
                            cmd.Parameters.AddWithValue("@UserPhoto", string.IsNullOrEmpty(userPhotoPath) ? (object)DBNull.Value : userPhotoPath);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();
                        }
                    }

                    lblMessage.Text = "Registration successful!";
                    // Optionally clear form fields here
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred: " + ex.Message;
                }
            }
        }
    }
}