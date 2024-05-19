@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------
if not defined TARGET_PROJECT_COMMAND (set TARGET_PROJECT_COMMAND=node)
if not defined TARGET_PROJECT_DEV_SERVER_PORT (set TARGET_PROJECT_DEV_SERVER_PORT=8000)

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    echo Start project %TARGET_PROJECT% develop server
    call %CLI_SHELL_DIRECTORY%\utils\libs.bat exec-docker %TARGET_PROJECT_COMMAND% %TARGET_PROJECT_DEV_SERVER_PORT%
    goto end

:args
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="--into" (set TARGET_PROJECT_COMMAND=bash)
    if "%COMMON_ARGS_KEY%"=="--port" (set TARGET_PROJECT_DEV_SERVER_PORT=%2)
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
    echo      --into            When container startup then going to container and don't startup dev-server.
    echo      --port            Setting dev-server port ( Default 3000 ).
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
