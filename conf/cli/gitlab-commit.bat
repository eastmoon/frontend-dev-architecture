@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker exec -ti %PROJECT_NAME%-infra-gitlab bash x-sync-projects.sh
    goto end

:args
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
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
