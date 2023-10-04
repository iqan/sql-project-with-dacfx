FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
LABEL maintainer="Iqan Shaikh"
WORKDIR /src
COPY Database.DacFx/Database.DacFx.sqlproj .
RUN dotnet restore
COPY Database.DacFx .
COPY init-db.sh .
RUN dotnet build

FROM mcr.microsoft.com/mssql/server:2022-latest AS server
WORKDIR /db
COPY --from=build /src/bin/Debug/Database.DacFx_Create.sql .
COPY --from=build /src/init-db.sh .
RUN ./init-db.sh Database.DacFx_Create.sql
