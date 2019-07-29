using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class mon_3_18pm : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Families_Users_adminID",
                table: "Families");

            migrationBuilder.DropIndex(
                name: "IX_Users_familyID",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Families_adminID",
                table: "Families");

            migrationBuilder.DropColumn(
                name: "adminID",
                table: "Families");

            migrationBuilder.CreateIndex(
                name: "IX_Users_familyID",
                table: "Users",
                column: "familyID",
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Users_familyID",
                table: "Users");

            migrationBuilder.AddColumn<long>(
                name: "adminID",
                table: "Families",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.CreateIndex(
                name: "IX_Users_familyID",
                table: "Users",
                column: "familyID");

            migrationBuilder.CreateIndex(
                name: "IX_Families_adminID",
                table: "Families",
                column: "adminID");

            migrationBuilder.AddForeignKey(
                name: "FK_Families_Users_adminID",
                table: "Families",
                column: "adminID",
                principalTable: "Users",
                principalColumn: "userID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
