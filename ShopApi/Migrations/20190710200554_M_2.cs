using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class M_2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Families_Users_adminID",
                table: "Families");

            migrationBuilder.DropIndex(
                name: "IX_Families_adminID",
                table: "Families");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Families_adminID",
                table: "Families",
                column: "adminID");

            migrationBuilder.AddForeignKey(
                name: "FK_Families_Users_adminID",
                table: "Families",
                column: "adminID",
                principalTable: "Users",
                principalColumn: "email",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
