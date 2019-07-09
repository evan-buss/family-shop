﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using ShopApi.Models;

namespace ShopApi.Migrations
{
    [DbContext(typeof(FamilyShopContext))]
    [Migration("20190709015040_update_listitem")]
    partial class update_listitem
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.SerialColumn)
                .HasAnnotation("ProductVersion", "2.2.4-servicing-10062")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            modelBuilder.Entity("ShopApi.Models.Family", b =>
                {
                    b.Property<long>("familyID")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("name");

                    b.HasKey("familyID");

                    b.ToTable("Family");
                });

            modelBuilder.Entity("ShopApi.Models.List", b =>
                {
                    b.Property<long>("ListID")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("description");

                    b.Property<long?>("familyID");

                    b.Property<string>("name");

                    b.HasKey("ListID");

                    b.HasIndex("familyID");

                    b.ToTable("List");
                });

            modelBuilder.Entity("ShopApi.Models.ListItem", b =>
                {
                    b.Property<long>("itemID")
                        .ValueGeneratedOnAdd();

                    b.Property<long?>("ListID");

                    b.Property<string>("description");

                    b.Property<string>("title");

                    b.Property<string>("useremail");

                    b.HasKey("itemID");

                    b.HasIndex("ListID");

                    b.HasIndex("useremail");

                    b.ToTable("ListItems");
                });

            modelBuilder.Entity("ShopApi.Models.User", b =>
                {
                    b.Property<string>("email")
                        .ValueGeneratedOnAdd();

                    b.Property<long?>("familyID");

                    b.Property<string>("passwordHash");

                    b.Property<byte[]>("passwordSalt");

                    b.Property<string>("username");

                    b.HasKey("email");

                    b.HasIndex("familyID");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("ShopApi.Models.List", b =>
                {
                    b.HasOne("ShopApi.Models.Family", "family")
                        .WithMany("lists")
                        .HasForeignKey("familyID");
                });

            modelBuilder.Entity("ShopApi.Models.ListItem", b =>
                {
                    b.HasOne("ShopApi.Models.List", "list")
                        .WithMany()
                        .HasForeignKey("ListID");

                    b.HasOne("ShopApi.Models.User", "user")
                        .WithMany()
                        .HasForeignKey("useremail");
                });

            modelBuilder.Entity("ShopApi.Models.User", b =>
                {
                    b.HasOne("ShopApi.Models.Family", "family")
                        .WithMany()
                        .HasForeignKey("familyID");
                });
#pragma warning restore 612, 618
        }
    }
}
