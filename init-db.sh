timeout=40
echo "Setting Environment variables."
export ACCEPT_EULA=Y
export MSSQL_SA_PASSWORD=SuperSecretPassword#1
echo "Environment variables set."
echo "File to run : $1"
echo "Starting SqlServer..."
/opt/mssql/bin/sqlservr &
sleep $timeout | echo "Waiting for $timeout seconds to start Sql Server"
echo "Creating DB..."
/opt/mssql-tools/bin/sqlcmd -U sa -P $MSSQL_SA_PASSWORD -i $1
echo "DB created."