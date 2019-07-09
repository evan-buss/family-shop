using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

namespace ShopApi.Migrations
{
    public partial class family_relation : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<byte[]>(
                name: "passwordSalt",
                table: "Users",
                nullable: true,
                oldClrType: typeof(string),
                oldNullable: true);

            migrationBuilder.AddColumn<long>(
                name: "familyID",
                table: "Users",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Family",
                columns: table => new
                {
                    familyID = table.Column<long>(nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn),
                    name = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Family", x => x.familyID);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Users_familyID",
                table: "Users",
                column: "familyID");

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Family_familyID",
                table: "Users",
                column: "familyID",
                principalTable: "Family",
                principalColumn: "familyID",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Users_Family_familyID",
                table: "Users");

            migrationBuilder.DropTable(
                name: "Family");

            migrationBuilder.DropIndex(
                name: "IX_Users_familyID",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "familyID",
                table: "Users");

            migrationBuilder.AlterColumn<string>(
                name: "passwordSalt",
                table: "Users",
                nullable: true,
                oldClrType: typeof(byte[]),
                oldNullable: true);
        }
    }
}
