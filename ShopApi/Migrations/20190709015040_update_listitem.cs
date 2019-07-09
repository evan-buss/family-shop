using Microsoft.EntityFrameworkCore.Migrations;

namespace ShopApi.Migrations
{
    public partial class update_listitem : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "userID",
                table: "ListItems");

            migrationBuilder.AddColumn<long>(
                name: "ListID",
                table: "ListItems",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "useremail",
                table: "ListItems",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_ListItems_ListID",
                table: "ListItems",
                column: "ListID");

            migrationBuilder.CreateIndex(
                name: "IX_ListItems_useremail",
                table: "ListItems",
                column: "useremail");

            migrationBuilder.AddForeignKey(
                name: "FK_ListItems_List_ListID",
                table: "ListItems",
                column: "ListID",
                principalTable: "List",
                principalColumn: "ListID",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_ListItems_Users_useremail",
                table: "ListItems",
                column: "useremail",
                principalTable: "Users",
                principalColumn: "email",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ListItems_List_ListID",
                table: "ListItems");

            migrationBuilder.DropForeignKey(
                name: "FK_ListItems_Users_useremail",
                table: "ListItems");

            migrationBuilder.DropIndex(
                name: "IX_ListItems_ListID",
                table: "ListItems");

            migrationBuilder.DropIndex(
                name: "IX_ListItems_useremail",
                table: "ListItems");

            migrationBuilder.DropColumn(
                name: "ListID",
                table: "ListItems");

            migrationBuilder.DropColumn(
                name: "useremail",
                table: "ListItems");

            migrationBuilder.AddColumn<long>(
                name: "userID",
                table: "ListItems",
                nullable: false,
                defaultValue: 0L);
        }
    }
}
