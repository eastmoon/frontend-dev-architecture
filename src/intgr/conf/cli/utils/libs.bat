@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:exec-docker
    echo ^> Create cache directory
    if NOT EXIST %CLI_DIRECTORY%\cache\dist (
        mkdir %CLI_DIRECTORY%\cache\dist
    )

    echo ^> Build image
    set PROJECT_NAME=frontend-dev-architecture
    set DOCKER_IMAGE_NAME=intgr.sdk:%PROJECT_NAME%
    docker build --rm^
        -t %DOCKER_IMAGE_NAME%^
        ./conf/docker/intgr-server

    echo ^> Startup service
    set INFRA_DOCKER_NETWORK=frontend-dev-architecture-network
    set DOCKER_CONTAINER_NAME=%PROJECT_NAME%-intgr-dev
    docker rm -f %DOCKER_CONTAINER_NAME%
    docker run -ti --rm ^
        -v %CLI_DIRECTORY%\app:/app ^
        -v %CLI_DIRECTORY%\cache\dist:/app/build ^
        -e PORT=%2 ^
        -p %2:80 ^
        -w "/app" ^
        --network %INFRA_DOCKER_NETWORK% ^
        --name %DOCKER_CONTAINER_NAME% ^
        %DOCKER_IMAGE_NAME%
    goto end

@rem ------------------- End method-------------------

:end
