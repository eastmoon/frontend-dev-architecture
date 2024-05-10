@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker exec -ti %PROJECT_NAME%-infra-gitlab bash x-sync-projects.sh %COMMON_ARGS_VALUE%
    goto end

:args
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="--repo" (set TARGET_REPOSITORY=%COMMON_ARGS_VALUE%)
    goto end

:short
    echo Commit code.
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Commit code form 'src' folder.
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    echo      --repo            Select repository ( defaul all repository).
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
