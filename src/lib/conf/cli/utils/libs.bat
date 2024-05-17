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
    set PROJECT_NAME=frontend-dev-architecture
    set DOCKER_IMAGE_NAME=node.sdk:%PROJECT_NAME%
    docker build --rm^
        -t %DOCKER_IMAGE_NAME%^
        ./conf/docker/node

    echo ^> Startup service
    set DOCKER_CONTAINER_NAME=%PROJECT_NAME%-node-lib-dev
    docker rm -f %DOCKER_CONTAINER_NAME%
    docker run -ti --rm ^
        -v %CLI_DIRECTORY%\app:/app ^
        -v %CLI_DIRECTORY%\cache\dist:/app/dist ^
        -v %CLI_DIRECTORY%\cache\node_modules:/app/node_modules ^
        -e PORT=%2 ^
        -p %2:%2 ^
        -w "/app" ^
        --name %DOCKER_CONTAINER_NAME% ^
        %DOCKER_IMAGE_NAME% %1
    goto end

@rem ------------------- End method-------------------

:end
