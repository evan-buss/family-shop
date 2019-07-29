using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class mon_3_55pm : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Users_Families_adminID",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Users_adminID",
                table: "Users");

            migrationBuilder.RenameColumn(
                name: "adminID",
                table: "Users",
                newName: "familyID");

            migrationBuilder.AddColumn<long>(
                name: "adminID",
                table: "Families",
                nullable: true);

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
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Families_familyID",
                table: "Users",
                column: "familyID",
                principalTable: "Families",
                principalColumn: "familyID",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Families_Users_adminID",
                table: "Families");

            migrationBuilder.DropForeignKey(
                name: "FK_Users_Families_familyID",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Users_familyID",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Families_adminID",
                table: "Families");

            migrationBuilder.DropColumn(
                name: "adminID",
                table: "Families");

            migrationBuilder.RenameColumn(
                name: "familyID",
                table: "Users",
                newName: "adminID");

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
    }
}
