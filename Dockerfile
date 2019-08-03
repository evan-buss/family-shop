FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ShopApi/*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ShopApi/. ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "ShopApi.dll"]
# RUN dotnet ef migrations script -o scripts/init.sql --idempotent
# dotnet ef migrations script -i --output scripts/init.sql

