# 整合專案

本專案用於整合開發與發佈前端專案，利用設定檔的規劃，將需要整合的專案下載，並基於開發運維 ( DevOps ) 的命令介面執行對應的命令。

## 整合定義檔

整合需要設定 Git 相關資訊的 .gitrc，以及專案設定的 .intgrrc 相關資訊。

#### .gitrc 格式

Git 對應資訊應為目標 Gitlab 主機的存取資料。

```
GIT_SERVER=<server-address>
GIT_ACCESS_NAME=<gitlab-access-name>
GIT_ACCESS_TOKEN=<gitlab-access-token>
```

#### .intgrrc 格式

整合專案會基於專案取得與啟動需求撰寫下述定義檔。

```
<ROUTE-NAME>$GIT:DEV@<GROUP>/<REPO>#<BRANCH>
<ROUTE-NAME>$LOC:PRD@<GROUP>/<REPO>#<BRANCH>
<ROUTE-NAME>$<GROUP>/<REPO>#<BRANCH>
```

+ 本專案會基於第一個關鍵字來尋找目標專案位置
    - ```GIT```：會在專案內的 ```cache/git``` 目錄中，並基於本專案自身的 gitrc 資訊下載或更新專案內容
    - ```LOC```：會在專案同層的目錄中尋找目標專案
    - 若沒提供第一關鍵字，則預設使用 ```LOC```
+ 本專案會基於第二關鍵字來對目標專案的 DevOps 命令介面執行動作
    - ```DEV```：使用 ```cli dev``` 指令，並指定動態的連結埠號碼
    - ```PRD```：使用 ```cli publish``` 指令，並將專案內的 ```cache/dist``` 做為內容的掛載目錄
    - 若沒有提供第二關鍵字，則預設使用 ```PRD```
+ 本專案會基於 ```<ROUTE-NAME>``` 在 Nginx 內產生必需的 location 設定，以此確保對應的轉址可正常使用
