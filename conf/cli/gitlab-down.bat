@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    @rem execute script
    docker rm -f %PROJECT_NAME%-infra-gitlab

    goto end

:args
    goto end

:short
    echo Close down.
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Close down gitlab service.
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
