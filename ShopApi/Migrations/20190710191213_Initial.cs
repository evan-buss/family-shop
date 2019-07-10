using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

namespace ShopApi.Migrations
{
    public partial class Initial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Lists",
                columns: table => new
                {
                    ListID = table.Column<long>(nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn),
                    name = table.Column<string>(nullable: true),
                    description = table.Column<string>(nullable: true),
                    familyID = table.Column<long>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lists", x => x.ListID);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    email = table.Column<string>(nullable: false),
                    username = table.Column<string>(nullable: true),
                    passwordHash = table.Column<string>(nullable: true),
                    passwordSalt = table.Column<byte[]>(nullable: true),
                    familyID = table.Column<long>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.email);
                });

            migrationBuilder.CreateTable(
                name: "Families",
                columns: table => new
                {
                    familyID = table.Column<long>(nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn),
                    name = table.Column<string>(nullable: true),
                    adminID = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Families", x => x.familyID);
                    table.ForeignKey(
                        name: "FK_Families_Users_adminID",
                        column: x => x.adminID,
                        principalTable: "Users",
                        principalColumn: "email",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "ListItems",
                columns: table => new
                {
                    itemID = table.Column<long>(nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn),
                    title = table.Column<string>(nullable: true),
                    description = table.Column<string>(nullable: true),
                    ListID = table.Column<long>(nullable: true),
                    useremail = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ListItems", x => x.itemID);
                    table.ForeignKey(
                        name: "FK_ListItems_Lists_ListID",
                        column: x => x.ListID,
                        principalTable: "Lists",
                        principalColumn: "ListID",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ListItems_Users_useremail",
                        column: x => x.useremail,
                        principalTable: "Users",
                        principalColumn: "email",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Families_adminID",
                table: "Families",
                column: "adminID");

            migrationBuilder.CreateIndex(
                name: "IX_ListItems_ListID",
                table: "ListItems",
                column: "ListID");

            migrationBuilder.CreateIndex(
                name: "IX_ListItems_useremail",
                table: "ListItems",
                column: "useremail");

            migrationBuilder.CreateIndex(
                name: "IX_Lists_familyID",
                table: "Lists",
                column: "familyID");

            migrationBuilder.CreateIndex(
                name: "IX_Users_familyID",
                table: "Users",
                column: "familyID");

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
                name: "FK_Families_Users_adminID",
                table: "Families");

            migrationBuilder.DropTable(
                name: "ListItems");

            migrationBuilder.DropTable(
                name: "Lists");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Families");
        }
    }
}
