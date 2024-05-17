// Ref : Moment.js, using to calculate time difference https://momentjs.com/docs/

// Import library
import jsonServer from "json-server";
import _ from "underscore";
import fs from "fs";
import path from "path";
import moment from "moment";

// Import configure library
import {validatorAPIConfig, validatorAPIError} from "./server.validator";
import {configureDatabase} from "./server.builder.database";
import {configureService} from "./server.builder.service";
import {configureRouter, routerList} from "./server.builder.router";

module.exports = (config) => {
    // 0. vaildator configure setting
    if (!validatorAPIConfig(config)) {
        validatorAPIError();
        return false;
    }

    // 1. Create database
    const databases = configureDatabase(config);
    const services = configureService(config);

    // 2. Server Declare variable
    var server = jsonServer.create();
    var router = jsonServer.router(databases);
    var db = router.db;

    // 2.1 Setting POST assign parameter parser to body.
    server.use(jsonServer.bodyParser);

    // 4. Add static router, using default response function.
    console.log("\n====== add static router =======");
    configureRouter(config, server, db, services);
    routerList();

    // Start server
    var middlewares = jsonServer.defaults();
    server.use(middlewares);
    server.use(router);
    server.listen(config.server.port, function() {
        console.log('[*] Custom JSON Server is running');
        console.log('\t- http://localhost:' + config.server.port);
        console.log('\n');
    });
}
