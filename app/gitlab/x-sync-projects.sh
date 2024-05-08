## 初始化 Gitlab 專案的主要資訊，以此方式建立並確保可重複執行整個設置行為
#!/bin/bash
set -e
ROOT=${PWD}

# Include library
source ./src/utils.sh
source ./src/git.sh

# Execute script

## Fetch all repository to main branch
for repo in $(ls code/);
do
    git-init RD ${repo} main
done

## Copy code to .git repository
echo-i "Copy code to .git"
rsync -avh --delete --exclude ".git/" --exclude='cache/' code/* .git/

## Push new commit into gitlab, if code has difference.
echo-i "Push code into gitlab"
for repo in $(ls .git/);
do
    cd .git/${repo}
    if [ $(git commit | grep "nothing to commit" | wc -l) -eq 0 ];
    then
        echo ${repo}, add new commit
        git-tree-add-commit ${repo} "feat: new feature from code `date "+%Y.%m.%d.%H%M%S"`"
    else
        echo ${repo}, nothing to commit
    fi
    cd ${ROOT}
done
