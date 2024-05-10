## 初始化 Gitlab 專案的主要資訊，以此方式建立並確保可重複執行整個設置行為
#!/bin/bash
set -e
ROOT=${PWD}

# Include library
source ./src/utils.sh
# Declare variable
source ./src/conf.sh

echo "User : root, Password : ${GIT_ROOT_PASSWORD}"
echo "Access Name : ${GIT_ACCESS_NAME}, Token : ${GIT_ACCESS_TOKEN}"
