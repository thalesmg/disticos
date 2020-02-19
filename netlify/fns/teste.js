// exports.handler = function(event, context, callback) {
//     callback(null, {
//     statusCode: 200,
//     body: "Cache chato"
//     });
// }

const requests = require("request");

exports.handler = function(event, context, callback) {
    requests({
        url: "https://httpbin.org/post",
        method: "POST",
        jar: true,
        qs: {
            "token": "10"
        }
    }, (error, res, body) => {
        if (error) {
            callback(null, {
                statusCode: 500,
                body: "Deu ruim!"
            });
        } else {
            callback(null, {
                statusCode: 200,
                body: body
            })
        }
    });
};
