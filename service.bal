import ballerina/sql;
import ballerina/io;

# Function to check if the given user's address matches the address in the database.
# 
# + user - The User object containing user information, including ID and address.
# + return - return true if the user's address matches the address in the database, false otherwise and
#  returns sql:Error if there is an error in the SQL execution.
 function checkAddress(User user) returns boolean|sql:Error? {

    sql:ParameterizedQuery query = `SELECT "address" FROM "user" WHERE "id"=${user.nic};`;

    sql:ExecutionResult|error result = dbQueryRow(query);
    io:println(result);

    if (result is error) {
        return false;
    } else {
        // compare the retrieved address with the user's address (case-insensitive).
        return (string:toLowerAscii(result["address"].toString()) == string:toLowerAscii(user.address));
    }

    
}

// function updateStatus(StatusEntry entry) returns string| error {
//     sql:ParameterizedQuery query = `INSERT INTO "status" ("user_id", "id_check_status", "address_check_status", "police_check_status")
// VALUES (${entry.nic}, ${entry.idCheckStatus}, ${entry.addressCheckStatus}, ${entry.policeCheckStatus});`;

//     io:println("query : " , query);
//     sql:ExecutionResult|error result = dbExecute(query);
//     io:println("result: ", result);

//     if(result is error) {
//         return result;
//     } else {
//         return "Successfully updated!";
//     }

// }

// function getStatusHistory(string nic) returns json[]|error {
//     sql:ParameterizedQuery query = `SELECT * from "status" where "user_id" = ${nic};`;

//     stream<StatusRecord, sql:Error?> result = check dbQuery(query);
//     io:println("result: ", result);

//     json[] statusRecords = [];

//     check from StatusRecord ent in result
//         do {
//             statusRecords.push(ent);
//         };

//     return statusRecords;

// }