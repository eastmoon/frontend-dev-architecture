@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:exec-docker
    @rem Declare variable
    set VAR_SRV_CMD=%1
    set VAR_SRV_PORT=%2
    set VAR_SRV_HOSTNAME=%3
    set VAR_SRV_STATE=%4
    if not defined VAR_SRV_STATE (set VAR_SRV_STATE%=-ti)

    @rem Initial directory
    echo ^> Create cache directory
    if NOT EXIST %CLI_DIRECTORY%\cache\dist (
        mkdir %CLI_DIRECTORY%\cache\dist
    )

    if NOT EXIST %CLI_DIRECTORY%\cache\node_modules (
        mkdir %CLI_DIRECTORY%\cache\node_modules
    )

    @rem Create service image with Dockerfile
    echo ^> Build image
    set PROJECT_NAME=frontend-dev-architecture
    set DOCKER_IMAGE_NAME=dummy.sdk:%PROJECT_NAME%
    docker build --rm^
        -t %DOCKER_IMAGE_NAME%^
        ./conf/docker/json-server

    echo ^> Startup service
    set INFRA_DOCKER_NETWORK=frontend-dev-architecture-network
    set DOCKER_CONTAINER_NAME=%PROJECT_NAME%-%VAR_SRV_HOSTNAME%
    docker rm -f %DOCKER_CONTAINER_NAME%
    docker run %VAR_SRV_STATE% --rm ^
        -v %CLI_DIRECTORY%\app:/app ^
        -v %CLI_DIRECTORY%\cache\node_modules:/app/node_modules ^
        -e PORT=%VAR_SRV_PORT% ^
        -h %VAR_SRV_HOSTNAME% ^
        -p %VAR_SRV_PORT%:%VAR_SRV_PORT% ^
        -w "/app" ^
        --network %INFRA_DOCKER_NETWORK% ^
        --name %DOCKER_CONTAINER_NAME% ^
        %DOCKER_IMAGE_NAME% %VAR_SRV_CMD%
    goto end

@rem ------------------- End method-------------------

:end
