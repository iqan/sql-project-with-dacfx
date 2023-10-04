timeout=20
echo "Setting Environment variables."
export ACCEPT_EULA=Y
export MSSQL_SA_PASSWORD=SuperSecretPassword#1
echo "Environment variables set."
echo "Starting SqlServr..."
/opt/mssql/bin/sqlservr &
sleep $timeout | echo "Waiting for $timeout seconds to start Sql Server"
echo "Creating DB..."
/opt/mssql-tools/bin/sqlcmd -U sa -P SuperSecretPassword#1 -q "CREATE DATABASE Database.DacFx"
/opt/mssql-tools/bin/sqlcmd -U sa -P SuperSecretPassword#1 -i $1
echo "DB created."