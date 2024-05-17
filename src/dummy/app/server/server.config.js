import "babel-polyfill";
import jsonserver from "./server.builder";

// Defined json-server configure
/*
  server.port, localhost:port
  path, basic database and service folder paths.
  apiDefault, basic json API infrastructure.
    - method, request method, [get, post, delete, put]
    - database, API response database file name.
    - service, API resquest callback handler.
    - router, Restful API custom routes, e.g xx.yy.zz/:token/:id
        - ref: https://github.com/typicode/json-server#add-custom-routes
  api, API list which json-server will listening.
    - [API name]: api infrastructure.
        - "default", structure the same with apiDefault.
        - {}, part of structure, diffe with apiDefault will keep.
        - [], same api name, differ method, and custom routers structure.
*/
const config = {
    server: {
        port: process.env.PORT
    },
    path: "db",
    apiDefault: {
        method: "get",
        database: "db.json",
        service: "srv.js",
        router: ""
    },
    api: {
        "demo.test1": "default",
        "demo.test2": {method: "post", router:":token/:id"},
        "demo": [
            "default",
            {method: "post", database: "db-other.json"}
        ]
    }
}

// Start json-server
jsonserver(config);
