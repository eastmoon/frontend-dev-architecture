// 第三方函式庫引用宣告
import _ from "underscore";
import fs from "fs";
import path from "path";

//

//
let error = [];

// 檢測檔案是否存在
export function assertFileExists(relativePath, key) {
    if (!fs.existsSync(relativePath)) {
        error.push(`${key} => file does not exist, path=${relativePath}`);
        return false;
    }
    return true;
}

// 檢測檔案夾是否存在
export function assertDirExists(relativePath, key) {
    // 1. 確定路徑正確
    if (!fs.existsSync(relativePath)) {
        error.push(`${key} => path does not exist, path=${relativePath}`);
        return false;
    }
    // 2. 確定為檔案夾
    if (!fs.statSync(relativePath).isDirectory()) {
        error.push(`${key} => path is not directory, path=${relativePath}`);
        return false;
    }
    return true;
}

export function assertStructure(config, key, info) {

    // 1. declare variable
    let dir = "";
    let file = "";

    // 2. Check api information
    if (info === "default") {
        // 2.1 status is default, copy api default structure.
        info = {};
        for (let attr in config.apiDefault) {
            info[attr] = config.apiDefault[attr];
        }
    } else if (typeof info === "object") {
        // 2.2 status type is object, add api default structure, if object don't have.
        for (let attr in config.apiDefault) {
            if (!Object.keys(info).includes(attr)) {
                info[attr] = config.apiDefault[attr];
            }
        }
    }

    // 3. Check database is exist.
    dir = path.join(config.path, key.replace(/[.]/g, "/"));
    file = path.join(dir, info.database);
    if (!assertFileExists(file, key)) {
        // 3.1 if folders and target file is not exist, setting error
        info.database = "error";
    }

    // 4. Check service is exist.
    dir = path.join(config.path, key.replace(/[.]/g, "/"));
    file = path.join(dir, info.service);
    if (!assertFileExists(file, key)) {
        // 3.1 if folders and target file is not exist, setting error
        info.service = "error";
    }

    return info;
}

export function validatorConfigureStructure(config) {
    let result = true;
    if ( typeof config !== "object" ) {
        error.push("config is not object");
        result = false;
    }
    if ( !Object.keys(config).includes("path") || typeof config.path !== "string" ) {
        error.push("config.path is not exist or format is no right.");
        result = false;
    }
    if ( !Object.keys(config).includes("api") || typeof config.api !== "object" ) {
        error.push("config.api is not exist");
        result = false;
    }
    if ( !Object.keys(config).includes("apiDefault") && typeof config.apiDefault !== "object" ) {
        error.push("config.apiDefault is not exist");
        result = false;
    }
    return result;
}

export function validatorAPIConfig(config) {
    // 0. Check api list is exist
    if (!validatorConfigureStructure(config)) {
        return false;
    }
    // 1. Search database file by config setting.
    for ( let key in config.api ) {
        // declare variable
        let info = config.api[key];

        // 2. Check api information
        if (info instanceof Array ) {
            for(let index in info) {
                info[index] = assertStructure(config, key, info[index]);
            }
        } else {
            info = assertStructure(config, key, info);
        }
        config.api[key] = info;
    }
    return true;
}

export function validatorAPIError() {
    error.map((msg) => {
        console.log(msg);
    });
    console.log("");
}
