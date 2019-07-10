using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class update_family_test : Migration
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

            migrationBuilder.DropColumn(
                name: "adminUserID",
                table: "Families");

            migrationBuilder.AddColumn<string>(
                name: "User",
                table: "Families",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Families_User",
                table: "Families",
                column: "User",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Families_Users_User",
                table: "Families",
                column: "User",
                principalTable: "Users",
                principalColumn: "email",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Families_Users_User",
                table: "Families");

            migrationBuilder.DropIndex(
                name: "IX_Families_User",
                table: "Families");

            migrationBuilder.DropColumn(
                name: "User",
                table: "Families");

            migrationBuilder.AddColumn<long>(
                name: "familyID",
                table: "Users",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "adminUserID",
                table: "Families",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.CreateIndex(
                name: "IX_Users_familyID",
                table: "Users",
                column: "familyID");

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Families_familyID",
                table: "Users",
                column: "familyID",
                principalTable: "Families",
                principalColumn: "familyID",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
