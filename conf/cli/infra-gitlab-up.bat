@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    @rem Build docker images
    cd %CLI_DIRECTORY%/conf/docker
    docker build -t gitlab.dev:%PROJECT_NAME% -f Dockerfile.gitlab .
    cd %CLI_DIRECTORY%

    @rem create cache directory
    @rem Setting gitlab cache directory
    set TARGET_DIR=%CLI_DIRECTORY%\cache\gitlab
    IF NOT EXIST %TARGET_DIR% (
        mkdir %TARGET_DIR%
    )
    set INFRA_GITLAB_PATH=%TARGET_DIR%
    set INFRA_GITLAB_APP_PATH=%CLI_DIRECTORY%\app\gitlab
    set INFRA_GIT_APP_PATH=%CLI_DIRECTORY%\src
    set INFRA_DOCKER_NETWORK=%PROJECT_NAME%-network

    @rem execute script
    docker rm -f %PROJECT_NAME%-infra-gitlab
    docker network create %INFRA_DOCKER_NETWORK%
    docker run -d ^
        -v %INFRA_GITLAB_PATH%\conf:/etc/gitlab ^
        -v %INFRA_GITLAB_PATH%\backups:/var/opt/gitlab/backups ^
        -v %INFRA_GITLAB_APP_PATH%:/shell ^
        -v %INFRA_GIT_APP_PATH%:/shell/code ^
        -p 7022:22 ^
        -p 9080:80 ^
        -p 9043:443 ^
        --network %INFRA_DOCKER_NETWORK% ^
        --hostname infra-gitlab ^
        --name %PROJECT_NAME%-infra-gitlab ^
        gitlab.dev:%PROJECT_NAME%

    @rem open browser
    start chrome --incognito "http://localhost:9080"

    goto end

:args
    goto end

:short
    echo Startup.
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup gitlab at '%PROJECT_NAME%-network' bridge network.
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
