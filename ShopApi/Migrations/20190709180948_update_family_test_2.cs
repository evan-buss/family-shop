using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class update_family_test_2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Families_Users_User",
                table: "Families");

            migrationBuilder.RenameColumn(
                name: "User",
                table: "Families",
                newName: "adminID");

            migrationBuilder.RenameIndex(
                name: "IX_Families_User",
                table: "Families",
                newName: "IX_Families_adminID");

            migrationBuilder.AddForeignKey(
                name: "FK_Families_Users_adminID",
                table: "Families",
                column: "adminID",
                principalTable: "Users",
                principalColumn: "email",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Families_Users_adminID",
                table: "Families");

            migrationBuilder.RenameColumn(
                name: "adminID",
                table: "Families",
                newName: "User");

            migrationBuilder.RenameIndex(
                name: "IX_Families_adminID",
                table: "Families",
                newName: "IX_Families_User");

            migrationBuilder.AddForeignKey(
                name: "FK_Families_Users_User",
                table: "Families",
                column: "User",
                principalTable: "Users",
                principalColumn: "email",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
