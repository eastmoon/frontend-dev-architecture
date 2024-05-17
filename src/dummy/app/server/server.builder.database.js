// Import library
import _ from "underscore";
import fs from "fs";
import path from "path";

//
function loadFile(db, config, key, info) {
    if (info.database !== "error") {
        let dir = path.join(config.path, key.replace(/[.]/g, "/"));
        let file = path.join(dir, info.database);
        let name = `${info.method}-${info.router}`;

        // Saving database
        if (!Object.keys(db).includes(key)) {
            db[key] = {};
        }
        db[key][name] = require(path.resolve(file));
    }
    return db;
}

//
export function configureDatabase(config) {
    let db = {};
    // 1. Search database file by config setting.
    for( let key in config.api ) {
        // declare variable
        let info = config.api[key];
        // 2. Check api information
        if (info instanceof Array ) {
            for(let index in info) {
                loadFile(db, config, key, info[index]);
            }
        } else {
            loadFile(db, config, key, info);
        }
    }
    // console.log(db);
    return db;
}
