﻿using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

namespace ShopApi.Migrations
{
    public partial class init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Lists",
                columns: table => new
                {
                    listID = table.Column<long>(nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn),
                    title = table.Column<string>(nullable: true),
                    description = table.Column<string>(nullable: true),
                    familyID = table.Column<long>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lists", x => x.listID);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    userID = table.Column<long>(nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn),
                    username = table.Column<string>(nullable: true),
                    email = table.Column<string>(nullable: true),
                    passwordHash = table.Column<string>(nullable: true),
                    passwordSalt = table.Column<byte[]>(nullable: true),
                    familyID = table.Column<long>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.userID);
                });

            migrationBuilder.CreateTable(
                name: "Families",
                columns: table => new
                {
                    familyID = table.Column<long>(nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn),
                    name = table.Column<string>(nullable: true),
                    adminuserID = table.Column<long>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Families", x => x.familyID);
                    table.ForeignKey(
                        name: "FK_Families_Users_adminuserID",
                        column: x => x.adminuserID,
                        principalTable: "Users",
                        principalColumn: "userID",
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
                    listID = table.Column<long>(nullable: true),
                    userID = table.Column<long>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ListItems", x => x.itemID);
                    table.ForeignKey(
                        name: "FK_ListItems_Lists_listID",
                        column: x => x.listID,
                        principalTable: "Lists",
                        principalColumn: "listID",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ListItems_Users_userID",
                        column: x => x.userID,
                        principalTable: "Users",
                        principalColumn: "userID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Families_adminuserID",
                table: "Families",
                column: "adminuserID");

            migrationBuilder.CreateIndex(
                name: "IX_ListItems_listID",
                table: "ListItems",
                column: "listID");

            migrationBuilder.CreateIndex(
                name: "IX_ListItems_userID",
                table: "ListItems",
                column: "userID");

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
                name: "FK_Families_Users_adminuserID",
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
