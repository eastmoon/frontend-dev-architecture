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
