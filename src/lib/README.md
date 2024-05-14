# 函式庫專案

## 專案設定

若要給頁面、元件專案引用，則需要在專案的根層建立一個 package.json 檔案，```npm``` 載入後會依據這個資訊進行軟體安裝。

```
{
  "name": "clibs",
  "version": "1.0.0",
  "files": [
    "app/src"
  ],
  "main": "./app/src/index.js"
}
```

其中最終要的參數如下：

+ name：影響專案載入後在頁面、元件專案 package.json 中的相依名稱
+ version：影響專案載入後頁面、元件專案認定相依庫版本的主要訊息
+ files：影響會被載入至 node_modules 中的實際目錄
+ main：影響 import 時認定的進入點

## 更新方式

若要在頁面、元件專案更新函數庫，則可以用 ```name``` 來更新。

```
npm update clibs
```
