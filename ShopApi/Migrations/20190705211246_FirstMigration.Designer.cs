﻿// <auto-generated />
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using ShopApi.Models;

namespace ShopApi.Migrations
{
    [DbContext(typeof(FamilyShopContext))]
    [Migration("20190705211246_FirstMigration")]
    partial class FirstMigration
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn)
                .HasAnnotation("ProductVersion", "2.2.4-servicing-10062")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            modelBuilder.Entity("ShopApi.Models.ListItem", b =>
                {
                    b.Property<long>("itemID")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("description");

                    b.Property<string>("title");

                    b.Property<long>("userID");

                    b.HasKey("itemID");

                    b.ToTable("ListItems");
                });
#pragma warning restore 612, 618
        }
    }
}