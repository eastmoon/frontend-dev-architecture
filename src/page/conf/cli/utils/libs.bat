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

    if NOT EXIST %CLI_DIRECTORY%\cache\node_modules (
        mkdir %CLI_DIRECTORY%\cache\node_modules
    )

    echo ^> Build image
    set DOCKER_IMAGE_NAME=react.sdk:%PROJECT_NAME%
    docker build --rm^
        -t %DOCKER_IMAGE_NAME%^
        ./conf/docker/react

    echo ^> Startup service
    set INFRA_DOCKER_NETWORK=frontend-dev-architecture-network
    set DOCKER_CONTAINER_NAME=%PROJECT_NAME%-react-page-dev
    docker rm -f %DOCKER_CONTAINER_NAME%
    docker run -ti --rm ^
        -v %CLI_DIRECTORY%\app:/app ^
        -v %CLI_DIRECTORY%\cache\dist:/app/build ^
        -v %CLI_DIRECTORY%\cache\node_modules:/app/node_modules ^
        -e PORT=%2 ^
        -p %2:%2 ^
        -w "/app" ^
        --network %INFRA_DOCKER_NETWORK% ^
        --name %DOCKER_CONTAINER_NAME% ^
        %DOCKER_IMAGE_NAME% %1
    goto end

@rem ------------------- End method-------------------

:end
