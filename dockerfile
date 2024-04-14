FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS builder

COPY . .

WORKDIR /src

RUN dotnet restore

RUN dotnet publish WebApplication1/WebApplication1.csproj -c Release -o /app

RUN dotnet test --logger "trx;LogFileName=./WebApplication1.trx"

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine

COPY --from=builder /app .

ENTRYPOINT ["dotnet", "WebApplication1.dll"]