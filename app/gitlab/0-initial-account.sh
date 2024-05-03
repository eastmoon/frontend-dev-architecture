## 初始化 Gitlab Token 資訊
## Ref : https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html
#!/bin/bash
set -e
# Include library
source ./src/utils.sh
# Declare variable
source ./src/conf.sh
# Execute script
## Initial root password
ROOT_PASSWORD='1234%^&*QWERtyui'
echo-i "Change Root passowrd to ${ROOT_PASSWORD}"
CMD="user = User.find_by_username('root');"
CMD="${CMD} user.password = '${ROOT_PASSWORD}';"
CMD="${CMD} user.password_confirmation = '${ROOT_PASSWORD}';"
CMD="${CMD} user.save!"
echo ${CMD}
gitlab-rails runner "${CMD}"
## Initial root access token
echo-i "Create Personal Access Token ${GIT_ACCESS_NAME} : ${GIT_ACCESS_TOKEN}"
CMD="if User.find_by_username('root').personal_access_tokens.find_by_token('${GIT_ACCESS_TOKEN}').nil?;"
CMD="${CMD} token = User.find_by_username('root').personal_access_tokens.create(scopes: [:api, :read_user, :read_api, :read_repository, :write_repository, :sudo], name: '${GIT_ACCESS_NAME}', expires_at: 365.days.from_now);"
CMD="${CMD} token.set_token('${GIT_ACCESS_TOKEN}');"
CMD="${CMD} token.save!;"
CMD="${CMD} else;"
CMD="${CMD} p '${GIT_ACCESS_NAME} exist';"
CMD="${CMD} end"
gitlab-rails runner "${CMD}"
##
echo-i "Generate access_token file"
echo ${GIT_ACCESS_TOKEN} > access_token
##
echo-i "Test Personal Access Token"
source ./src/gitlab.sh
echo-i $(gitlab-version)
