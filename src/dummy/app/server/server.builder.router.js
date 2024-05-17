// Import library
import _ from "underscore";
import fs from "fs";
import path from "path";

//
import {assertDirExists} from "./server.validator";
//
let routers = [];
//
function createAPI(server, db, services, info, key) {
    // if API does not have database and service, don't creat in server.
    if (info.database === "error" && info.service === "error") {
        return false;
    }

    // 1. Retrieve api name
    let api = `/${key.replace(/[.]/g, "/")}`;
    if (Object.keys(info).includes("router")) {
        api += `/${info.router}`;
    }

    // 2. Set server router
    if (Object.keys(info).includes("method") && Object.keys(server).includes(info.method)) {
        routers.push(`[${info.method}] ${api}`);
        server[info.method](api, (req, res) => {
            // stdout info
            console.log("-- [" + req.method + "] " + req.url);
            // 1. Retrieve request params and information.
            if (Object.keys(req.params).length > 0) {
                console.log("params : ", req.params);
            }
            if (req.method === "GET") {
                console.log(req.query);
            }
            else {
                console.log(req.body);
            }
            //
            let name = `${info.method}-${info.router}`;
            let sdb = db.get(key).get(name);
            if (info.service === "error") {
                // 2. Return request result, if doesn't have custom service, but have database.
                res.jsonp(sdb);
            } else {
                // 3. Running custom service.
                services[key][name](req, res, sdb);
            }
        })
    }
}
//
export function configureRouter(config, server, db, services) {
    _.map(config.api, (value, key, list) => {
        if (value instanceof Array ) {
            for(let index in value) {
                createAPI(server, db, services, value[index], key);
            }
        } else {
            createAPI(server, db, services, value, key);
        }
    });
}

export function routerList() {
    routers.map((msg, index) => {
        console.log(`[${index}]${msg}`);
    });
    console.log("");
}
