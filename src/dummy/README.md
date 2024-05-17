# 偽裝伺服器

+ [JSON Server](https://github.com/typicode/json-server)

本專案是基於 JSON 伺服器設計的本地資料偽裝伺服器，其專案結構有兩個部分。

```
app
  └ db
  └ server
```

+ ```app/server```：伺服器運作主體
+ ```app/db```：偽裝資料與服務儲存目錄

由於 JSON 伺服器的範本是使用一個標準的 db.json 來回應內容，但這樣結構若面對複雜路由且資料量龐大時，會難以維護；對此，基於 JSON 伺服器的[客製化路由 ( Custom Routes )](https://github.com/typicode/json-server/tree/v0?tab=readme-ov-file#custom-routes-example) 來規劃與設計本項目

## 伺服器定義

偽裝伺服器會依據定義檔的內容 [server.config.js](./app/server/server.config.js)，檢查服務與資料是否存在並回應，倘若定義與目錄資料不匹配則不會產生路由資訊，其定義檔結構如下：

```
const config = {
    server: { port: process.env.PORT },
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
            {method: "post", database: "db-other.json", router:"*"}
        ]
    }
}
```

#### 伺服器定義

+ ```server: { port: process.env.PORT }```：伺服器聆聽的連接埠，此值會根據環境變數 POST 更改，無需調整。
+ ```path: "db"```：JSON 伺服器的資料來源

#### 路由預設值

+ ```method```：此路由的 HTTP Method
+ ```database```：此路由的資料檔名稱
+ ```service```：此路由的服務檔名稱
+ ```router```：此路由的參數路徑結構，詳細規則參考[Rewriter Example](https://github.com/typicode/json-server/tree/v0?tab=readme-ov-file#rewriter-example)

#### 路由定義

本專案的 JSON 伺服器有多少路由是參考 ```api: { ... }``` 內的設定，其設定規範如下：

+ 路由對應目錄
在 api 的物件中，每個 key 都被認定指向一個目錄，因此 ```demo``` 指向 ```demo``` 目錄、```demo.test1``` 指向 ```demo/test1``` 目錄，倘若目錄不存在則

+ 替換預設值
若 key 對應的值為 default 字串，該路由會直接使用路由預設值的所有設定；反之，若要替換則 key 對應的值為一個物件或矩陣，對應物件則表示該路由對應一個 HTTP Method 行為、對應矩陣則認定為多個 HTTP Method 行為；替換物件的內容參考路由預設 key 替換，因此 ```demo.test2``` 替換了 HTTP Method 並修改參數路徑結構為 ```:token/:id```，而 ```demo``` 則是定義了兩個行為預設的 GET 和自訂的 POST，且 POST 的資料檔使用 ```db-other.json```。

+ 自訂服務替換內容回應
在此專案的設計下，倘若一個路由對應的目錄存在 ```database```、```service``` 指定的檔案，則會優先執行 ```service``` 指定檔案的函數並將 ```database``` 內容作為資料傳入，反之若沒有 ```service```則會依據 ```database``` 檔案直接回傳。

#### 範例執行

+ ```curl --request GET http://localhost:3005/demo```
+ ```curl --request POST http://localhost:3005/demo```
+ ```curl --request GET http://localhost:3005/demo/test1```
+ ```curl --request POST http://localhost:3005/demo/test2/1234/5678```
