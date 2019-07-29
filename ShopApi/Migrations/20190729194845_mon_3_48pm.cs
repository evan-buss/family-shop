using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class mon_3_48pm : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Users_Families_familyID",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Users_familyID",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "familyID",
                table: "Users");

            migrationBuilder.AddColumn<long>(
                name: "adminID",
                table: "Users",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Users_adminID",
                table: "Users",
                column: "adminID",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Families_adminID",
                table: "Users",
                column: "adminID",
                principalTable: "Families",
                principalColumn: "familyID",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Users_Families_adminID",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Users_adminID",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "adminID",
                table: "Users");

            migrationBuilder.AddColumn<long>(
                name: "familyID",
                table: "Users",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.CreateIndex(
                name: "IX_Users_familyID",
                table: "Users",
                column: "familyID",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Families_familyID",
                table: "Users",
                column: "familyID",
                principalTable: "Families",
                principalColumn: "familyID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
