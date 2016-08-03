var http = require('http');

exports.myHandler = function(event, context, callback) {
    // setup request options and parameters
    var options = {
      host: event.requestParams.hostname,
      port: event.requestParams.port,
      path: event.requestParams.path,
      method: event.requestParams.method
    };

    // if you have headers set them otherwise set the property to an empty map
    if (event.params && event.params.header && Object.keys(event.params.header).length > 0) {
        options.headers = event.params.header
    } else {
        options.headers = {};
    }

    // Force the user agent and the "forwaded for" headers because we want to
    // take them from the API Gateway context rather than letting Node.js set the Lambda ones
    options.headers["User-Agent"] = event.context["user-agent"];
    options.headers["X-Forwarded-For"] = event.context["source-ip"];
    // if I don't have a content type I force it application/json
    // Test invoke in the API Gateway console does not pass a value
    if (!options.headers["Content-Type"]) {
        options.headers["Content-Type"] = "application/json";
    }
    // build the query string
    if (event.params && event.params.querystring && Object.keys(event.params.querystring).length > 0) {
        var queryString = generateQueryString(event.params.querystring);

        if (queryString !== "") {
            options.path += "?" + queryString;
        }
    }

    // Define my callback to read the response and generate a JSON output for API Gateway.
    // The JSON output is parsed by the mapping templates
    callback = function(response) {
        var responseString = '';

        // Another chunk of data has been recieved, so append it to `str`
        response.on('data', function (chunk) {
            responseString += chunk;
        });

        // The whole response has been received
        response.on('end', function () {
            // Parse response to json
            var jsonResponse = JSON.parse(responseString);

            var output = {
                status: response.statusCode,
                bodyJson: jsonResponse,
                headers: response.headers
            };

            // if the response was a 200 we can just pass the entire JSON back to
            // API Gateway for parsing. If the backend returned a non 200 status
            // then we return it as an error
            if (response.statusCode == 200) {
                context.succeed(output);
            } else {
                // set the output JSON as a string inside the body property
                output.bodyJson = responseString;
                // stringify the whole thing again so that we can read it with
                // the $util.parseJson method in the mapping templates
                context.fail(JSON.stringify(output));
            }
        });
    }

    var req = http.request(options, callback);

    if (event.bodyJson && event.bodyJson !== "") {
        req.write(JSON.stringify(event.bodyJson));
    }

    req.on('error', function(e) {
        console.log('problem with request: ' + e.message);
        context.fail(JSON.stringify({
            status: 500,
            bodyJson: JSON.stringify({ message: "Internal server error" })
        }));
    });

    req.end();
}

function generateQueryString(params) {
    var str = [];
    for(var p in params) {
        if (params.hasOwnProperty(p)) {
            str.push(encodeURIComponent(p) + "=" + encodeURIComponent(params[p]));
        }
    }
    return str.join("&");
}
