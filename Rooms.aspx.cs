using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hostelpg
{
    public partial class Rooms : Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelPGDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                ClearForm(); // Ensure top form is empty on first load
            }
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Floor, Block, Room, Bed, RentAmount, Status FROM RoomDetails ORDER BY Floor, Block, Room, Bed";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvRooms.DataSource = dt;
                gvRooms.DataBind();
            }
        }

        private void ClearForm()
        {
            txtFloor.Text = "";
            txtBlock.Text = "";
            txtRoom.Text = "";
            txtBed.Text = "";
            txtRentAmount.Text = "";
            lblMessage.Text = "";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = @"INSERT INTO RoomDetails (Floor, Block, Room, Bed, RentAmount, Status)
                                         VALUES (@Floor, @Block, @Room, @Bed, @RentAmount, 'Available')";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Floor", txtFloor.Text.Trim());
                            cmd.Parameters.AddWithValue("@Block", txtBlock.Text.Trim());
                            cmd.Parameters.AddWithValue("@Room", txtRoom.Text.Trim());
                            cmd.Parameters.AddWithValue("@Bed", txtBed.Text.Trim());
                            cmd.Parameters.AddWithValue("@RentAmount", decimal.Parse(txtRentAmount.Text.Trim()));

                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    lblMessage.Text = "Bed added successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    ClearForm();
                    BindGrid();
                }
                catch (SqlException ex) when (ex.Number == 2627 || ex.Number == 2601)
                {
                    lblMessage.Text = "This bed already exists in the room!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void gvRooms_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvRooms.EditIndex = e.NewEditIndex;
            BindGrid(); // Only refreshes grid, does NOT touch top form
        }

        protected void gvRooms_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvRooms.EditIndex = -1;
            BindGrid();
        }

        protected void gvRooms_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvRooms.DataKeys[e.RowIndex].Value);

                TextBox txtFloorEdit = (TextBox)gvRooms.Rows[e.RowIndex].FindControl("txtFloorEdit");
                TextBox txtBlockEdit = (TextBox)gvRooms.Rows[e.RowIndex].FindControl("txtBlockEdit");
                TextBox txtRoomEdit = (TextBox)gvRooms.Rows[e.RowIndex].FindControl("txtRoomEdit");
                TextBox txtBedEdit = (TextBox)gvRooms.Rows[e.RowIndex].FindControl("txtBedEdit");
                TextBox txtRentEdit = (TextBox)gvRooms.Rows[e.RowIndex].FindControl("txtRentEdit");
                DropDownList ddlStatusEdit = (DropDownList)gvRooms.Rows[e.RowIndex].FindControl("ddlStatusEdit");

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE RoomDetails
                                     SET Floor = @Floor, Block = @Block, Room = @Room,
                                         Bed = @Bed, RentAmount = @RentAmount, Status = @Status
                                     WHERE Id = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Floor", txtFloorEdit.Text.Trim());
                        cmd.Parameters.AddWithValue("@Block", txtBlockEdit.Text.Trim());
                        cmd.Parameters.AddWithValue("@Room", txtRoomEdit.Text.Trim());
                        cmd.Parameters.AddWithValue("@Bed", txtBedEdit.Text.Trim());
                        cmd.Parameters.AddWithValue("@RentAmount", decimal.Parse(txtRentEdit.Text.Trim()));
                        cmd.Parameters.AddWithValue("@Status", ddlStatusEdit.SelectedValue);
                        cmd.Parameters.AddWithValue("@Id", id);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                gvRooms.EditIndex = -1;
                BindGrid();
                lblMessage.Text = "Bed updated successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Update failed: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvRooms_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvRooms.DataKeys[e.RowIndex].Value);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM RoomDetails WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                BindGrid();
                lblMessage.Text = "Bed deleted successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Cannot delete bed (may be occupied): " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}