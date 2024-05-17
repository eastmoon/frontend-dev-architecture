# 前端開發架構

使用者介面依據不同的用戶平台會採用不同的語言與框架設計，而常見的區分是將用戶端 ( Client-Side )、網頁端 ( Website )，而這兩者最大區別是用戶端多數為基於平台的語言與框架開發，後者則是由平台瀏覽器啟動的跨平台頁面，在網際網路服務中的也稱為前端 ( Frontend )。

由於前端網頁不同於用戶端終端，具有較高的擴充性，這樣特性在雲端服務盛行的網路世代更為突顯；然而擴充性的特徵也標示著前端項目在架構上並非一體成形，而是逐次修改或添加並整合而成，在這概念下也延伸出了不同的開發概念，從而為更大的軟體結構提供擴充性。

+ [網際網路應用程式](https://github.com/eastmoon/react-application-project)
+ [偽資料伺服器](https://github.com/eastmoon/dummy-data-server)
+ [微前端架構](https://github.com/eastmoon/research-microfontend)

基於上述的研究項目，本專案專注在各專案的整合運用，使其在開發雖各自獨立，但產品仍為一個完整個體。

## 簡介

基於本專案設計概念，前端產品是由下列類型前端專案整合而成：

+ 頁面專案：基於前端框架 React、Vue、Angular 為內容的 SPA 項目專案
+ 元件專案：基於前端框架 React、Vue、Angular 為內容的 WebComponent 項目專案
+ 函式庫專案：基於 Pure JavaScript 或前端框架 React、Vue、Angular 為內容的項目專案
+ 假資料專案：偽裝資料伺服器，提供前端在開發階段所需的測試資料
+ 整合專案：管理與啟動多個前端專案

此項目中所有專案會保存於 Git，並透過 Git 進行管理與整合。

## 指令

### Gitlab 專案管理服務

由於本項目需要透過 git 管理專案溝通，因此請在執行範例前先啟動 gitlab 環境

+ ```cli gitlab up```：啟動 gitlab 服務
+ ```cli gitlab down```：關閉 gitlab 服務
+ ```cli gitlab info```：顯示 gitlab 的帳號與存取代碼的設定資訊
+ ```cli gitlab init```：初始化 gitlab 內容，包括設定帳號密碼、存取代碼、群組、用戶、專案建置
+ ```cli gitlab commit```：將專案變更的內容上傳至 gitlab
    - ```cli gitlab commit --repo=<target_repository```：指定特定專案上傳至 gitlab

需要注意，由於 gitlab 啟動需要些許時間，在執行 ```init``` 前，請刷新 gitlab 網站直到登入畫面出現。

### 專案管理服務

專案範例皆依據開發運維設計需要提供管理指令，其主要指令如下：

+ ```cli dev```：啟動開發伺服器
    - ```cli dev --into```：啟動開發環境，並進入其中，此模式若要啟動開發伺服器請使用 ```npm run start```
    - ```cli dev --port=[number]```：啟動的開發環境與開發伺服器會使用的連結埠，若以此設定，則環境啟動預設為各專案自行設定
+ ```cli publish```：啟動開發環境並發佈專案內容至目錄 ```cache/dist``` 中

實際執行細節差異可詳見後續專案項目說明。

## 專案

```
repository
  └ app
    └ gitlab
  └ src
    └ page
    └ com
    └ lib
    └ dummy
    └ intgr
```

### 頁面專案

前端網頁的進入點是以頁面專案構成，無論是傳統 DHTML 概念到主流前端框架 ( Vue、React、Angular ) 都是以頁面為基準，從而設計的單頁面應用程式 ( Single Page Application、SPA )。

頁面專案範例 [page](./src/page) 使用 React 框架設計，詳細內容參考連結；開發指令 ```cli dev``` 預設啟動連結埠 3000。

### 元件專案

### 函式庫專案

前端網頁的函式庫專案，是將專案中共通的 JavaScript 函式、類別庫整理成專案，並用作為頁面、元件專案的相依第三方載入。

若要使用函式庫專案，可以使用 ```npm``` 套件管理工具，指定 gitlab 主機中的專案進行下載。

```
npm install --save git+http://[token-name]:[token]@[git-server-address]/[git-repository]#[git-branch]
```

本專案啟動的 Gitlab 會產生如下數劇供組合完整句型：
+ token name: automation-token,
+ token: 12345QWERTasdfgZXCVB
+ git-server-address: infra-gitlab
+ git-repository: RD/lib
+ git-branch: main
+ 句型 ```npm install --save git+http://automation-token:12345QWERTasdfgZXCVB@infra-gitlab/RD/lib#main```

函式庫專案範例 [lib](./src/lib)，詳細設計細節可參考連結內文說明；開發指令 ```cli dev``` 預設啟動連結埠 3003。

### 元件庫專案

前端網頁的元件庫專案，不同於函式庫專案的使用方式，主要是將元件庫內容進行編譯後放置於網頁檔案伺服器 ( Http Fils Server、HFS )，以此作為頁面、元件專案的相依第三方載入

若要使用函式庫專案，可以使用 ```npm``` 套件管理工具，指定 hfs 主機中的專案進行下載。

```
npm install --save http://[http-file-server-address]/[project-name].tgz
```

元件庫的建立需要參考各框架的專案設定方式，以確保編譯後的內容符合頁面、元件專案需要。

+ [Vue](https://cli.vuejs.org/guide/build-targets.html#library)
+ [Angular](https://angular.io/guide/creating-libraries)


### 假資料專案

### 整合專案

## 文獻

+ [NPM Docs](https://docs.npmjs.com/about-npm)
    - [configuration package.json](https://docs.npmjs.com/cli/v10/configuring-npm/package-json)
    - [configuration .npmrc](https://docs.npmjs.com/cli/v10/configuring-npm/npmrc)
+ [Setting Up a Custom JS Library Repo](https://community.appsmith.com/tutorial/setting-custom-js-library-repo)
+ [Creating Custom JavaScript Libraries: A Guide to Reusable and Efficient Code](https://blog.bitsrc.io/creating-custom-javascript-libraries-a-guide-to-reusable-and-efficient-code-2bcaff45339d)
+ [How to use a package from the git repository as a node module](https://medium.com/pravin-lolage/how-to-use-your-own-package-from-git-repository-as-a-node-module-8b543c13957e)
+ [How to Create and Publish a React Component Library](https://dev.to/alexeagleson/how-to-create-and-publish-a-react-component-library-2oe)
