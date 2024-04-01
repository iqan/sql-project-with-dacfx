FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
LABEL maintainer="Iqan Shaikh"
WORKDIR /src
COPY Database.DacFx .
COPY init-db.sh .
# If you use "SqlAzureV12DatabaseSchemaProvider", use the following line to replace it with "Sql160DatabaseSchemaProvider"
# RUN sed -i -r "s/Microsoft.Data.Tools.Schema.Sql.SqlAzureV12DatabaseSchemaProvider/Microsoft.Data.Tools.Schema.Sql.Sql160DatabaseSchemaProvider/g" CustomsClearance.sqlproj
RUN dotnet build

FROM mcr.microsoft.com/mssql/server:2022-latest AS server
LABEL maintainer="Iqan Shaikh"
WORKDIR /db
COPY --from=build /src/bin/Debug/Database.DacFx_Create.sql .
COPY --from=build --chown=mssql /src/init-db.sh .
RUN chmod +x init-db.sh
RUN ./init-db.sh Database.DacFx_Create.sql

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS testbuilder
LABEL maintainer="Iqan Shaikh"
WORKDIR /src
COPY . .
WORKDIR /src/Database.Tests
RUN dotnet build

FROM server AS test
LABEL maintainer="Iqan Shaikh"
WORKDIR /db
COPY --from=testbuilder /src/Database.Tests/bin/Debug/Database.Tests_Create.sql .
COPY --from=testbuilder --chown=mssql /src/init-db.sh .
RUN chmod +x init-db.sh
RUN ./init-db.sh Database.Tests_Create.sql
