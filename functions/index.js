// We import the cloud functions framework dependency
// so that we can send a visible response to a client
import Functions from '@google-cloud/functions-framework'

// functionName must match ../terraform/functions.tf ~line 35:
// google_cloudfunctions_function.deployed_function.entry_point
Functions.http('hello_tf', (req, res) => {
    res.status(200).send("Hello terraform functions")
})

