@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    echo Publish project %TARGET_PROJECT%
    call %CLI_SHELL_DIRECTORY%\utils\libs.bat exec-docker build 3000
    goto end

:args
    goto end

:short
    echo Publish mode
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo List command with publish
    echo.
    echo Options:
    echo      --help, -h        Show more command information.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
