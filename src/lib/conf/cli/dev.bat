@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------
if not defined TARGET_PROJECT_COMMAND (set TARGET_PROJECT_COMMAND=node)
if not defined TARGET_PROJECT_DEV_SERVER_PORT (set TARGET_PROJECT_DEV_SERVER_PORT=3003)
if not defined TARGET_PROJECT_DEV_SERVER_HOSTNAME (set TARGET_PROJECT_DEV_SERVER_HOSTNAME=lib)

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    if defined TARGET_PROJECT_STOP (
        echo Stop project %PROJECT_NAME% develop server
        call %CLI_SHELL_DIRECTORY%\utils\libs.bat remove-docker ^
            %TARGET_PROJECT_DEV_SERVER_HOSTNAME%
    ) else (
        echo Start project %PROJECT_NAME% develop server
        call %CLI_SHELL_DIRECTORY%\utils\libs.bat exec-docker ^
            %TARGET_PROJECT_COMMAND% ^
            %TARGET_PROJECT_DEV_SERVER_PORT% ^
            %TARGET_PROJECT_DEV_SERVER_HOSTNAME% ^
            %TARGET_PROJECT_DEV_SERVER_IN_BACKGROUND%
    )
    goto end

:args
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="--stop" (set TARGET_PROJECT_STOP=true)
    if "%COMMON_ARGS_KEY%"=="--into" (set TARGET_PROJECT_COMMAND=bash)
    if "%COMMON_ARGS_KEY%"=="--port" (set TARGET_PROJECT_DEV_SERVER_PORT=%2)
    if "%COMMON_ARGS_KEY%"=="--hostname" (set TARGET_PROJECT_DEV_SERVER_HOSTNAME=%2)
    if "%COMMON_ARGS_KEY%"=="--detach" (set TARGET_PROJECT_DEV_SERVER_IN_BACKGROUND=--detach)
    goto end

:short
    echo Developer mode
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Startup developer server
    echo.
    echo Options:
    echo      --help, -h        Show more command information.
    echo      --stop            Stop container if dev-server was on work.
    echo      --into            When container startup then going to container and don't startup dev-server.
    echo      --port            Setting dev-server port ( Default %TARGET_PROJECT_DEV_SERVER_PORT% ).
    echo      --hostname        Setting dev-server hostname ( Default %TARGET_PROJECT_DEV_SERVER_HOSTNAME% ).
    echo      --detach          Run container in background.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
