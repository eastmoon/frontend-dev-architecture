## 初始化 Gitlab 專案的主要資訊，以此方式建立並確保可重複執行整個設置行為
#!/bin/bash
set -e

## Remove shell tmp, log folder
[ -d ./.log ] && rm -rf ./.log
[ -d ./.tmp ] && rm -rf ./.tmp

# Include library
source ./src/utils.sh
source ./src/gitlab.sh

# Execute script
## Retrieve gitlab version infromation
echo-i $(gitlab-version)

## create group
echo-i "Create Group"
create-group RD "This group for development repository."
retrieve-group

## create user
echo-i "Create User"
create-user tuser tuser@testmail.com
retrieve-user

echo-i "Add User into Group"
add-user-to-group tuser RD
