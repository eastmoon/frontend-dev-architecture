## 初始化 Gitlab 專案的主要資訊，以此方式建立並確保可重複執行整個設置行為
#!/bin/bash
set -e

# Include library
source ./src/utils.sh
source ./src/gitlab.sh
source ./src/git.sh

# Execute script
## Retrieve gitlab version infromation
#echo-i $(gitlab-version)

## Remove .git directory
rm -rf .git
mkdir .git

for d in $(find ./code -mindepth 1 -maxdepth 1 -type d);
do
    PROJECT_NAME=${d##*/}
    echo "Create project '${PROJECT_NAME}'"
    create-project-with-readme ${PROJECT_NAME} RD
done

## Setting protect branch
retrieve-project
for filename in $(ls .tmp/project_*)
do
    PROJ_ID=$(jshon -e id < ${filename})
    PROJ_ID=${PROJ_ID//\ }
    PROJ_ID=${PROJ_ID//\"}
    PROJ_NAME=$(jshon -e name < ${filename})
    PROJ_NAME=${PROJ_NAME//\ }
    PROJ_NAME=${PROJ_NAME//\"}
    PROJ_GROUP=$(jshon -e namespace -e path < ${filename})
    PROJ_GROUP=${PROJ_GROUP//\ }
    PROJ_GROUP=${PROJ_GROUP//\"}
    if [[ ${PROJ_GROUP} != *"gitlab"* ]];
    then
        ### 1. unprotect default branch "main"
        unprotect-branch ${PROJ_NAME} main
        ### 2. setting protect branch white card "release*", it will protect all "release" title branch
        protect-branch ${PROJ_NAME} release*
        ### 3. git clone repository
        git-init ${PROJ_GROUP} ${PROJ_NAME} main
        ### 4. create new release from main ( it will new branch from git-init branch )
        git-init-branch ${PROJ_NAME} release
    fi
done
