import ballerina/sql;
import ballerinax/postgresql;

configurable string host = ?;
configurable string username = ?;
configurable string db = ?;
configurable string password = ?;
configurable int port = ?;

function dbQuery(sql:ParameterizedQuery query) returns error|sql:ExecutionResult {
    postgresql:Client dbClient = check new (host, username, password,
    db, port, connectionPool = {maxOpenConnections: 5});

    sql:ExecutionResult|error result = dbClient->queryRow(query);

    check dbClient.close();

    return result;
};