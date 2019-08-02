using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class update1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.AlterColumn<long>(
                name: "familyID",
                table: "Users",
                nullable: false,
                oldClrType: typeof(long),
                oldNullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "updateTest",
                table: "Users",
                nullable: false,
                defaultValue: false);

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Users_Families_familyID",
                table: "Users");

            migrationBuilder.DropIndex(
                name: "IX_Users_familyID",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "updateTest",
                table: "Users");

            migrationBuilder.AlterColumn<long>(
                name: "familyID",
                table: "Users",
                nullable: true,
                oldClrType: typeof(long));

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
    }
}
