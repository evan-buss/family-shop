using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class update_family_admin : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_List_Family_familyID",
                table: "List");

            migrationBuilder.DropForeignKey(
                name: "FK_ListItems_List_ListID",
                table: "ListItems");

            migrationBuilder.DropForeignKey(
                name: "FK_Users_Family_familyID",
                table: "Users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_List",
                table: "List");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Family",
                table: "Family");

            migrationBuilder.RenameTable(
                name: "List",
                newName: "Lists");

            migrationBuilder.RenameTable(
                name: "Family",
                newName: "Families");

            migrationBuilder.RenameIndex(
                name: "IX_List_familyID",
                table: "Lists",
                newName: "IX_Lists_familyID");

            migrationBuilder.AddColumn<long>(
                name: "adminUserID",
                table: "Families",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Lists",
                table: "Lists",
                column: "ListID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Families",
                table: "Families",
                column: "familyID");

            migrationBuilder.AddForeignKey(
                name: "FK_ListItems_Lists_ListID",
                table: "ListItems",
                column: "ListID",
                principalTable: "Lists",
                principalColumn: "ListID",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Lists_Families_familyID",
                table: "Lists",
                column: "familyID",
                principalTable: "Families",
                principalColumn: "familyID",
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
                name: "FK_ListItems_Lists_ListID",
                table: "ListItems");

            migrationBuilder.DropForeignKey(
                name: "FK_Lists_Families_familyID",
                table: "Lists");

            migrationBuilder.DropForeignKey(
                name: "FK_Users_Families_familyID",
                table: "Users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Lists",
                table: "Lists");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Families",
                table: "Families");

            migrationBuilder.DropColumn(
                name: "adminUserID",
                table: "Families");

            migrationBuilder.RenameTable(
                name: "Lists",
                newName: "List");

            migrationBuilder.RenameTable(
                name: "Families",
                newName: "Family");

            migrationBuilder.RenameIndex(
                name: "IX_Lists_familyID",
                table: "List",
                newName: "IX_List_familyID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_List",
                table: "List",
                column: "ListID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Family",
                table: "Family",
                column: "familyID");

            migrationBuilder.AddForeignKey(
                name: "FK_List_Family_familyID",
                table: "List",
                column: "familyID",
                principalTable: "Family",
                principalColumn: "familyID",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_ListItems_List_ListID",
                table: "ListItems",
                column: "ListID",
                principalTable: "List",
                principalColumn: "ListID",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Family_familyID",
                table: "Users",
                column: "familyID",
                principalTable: "Family",
                principalColumn: "familyID",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
