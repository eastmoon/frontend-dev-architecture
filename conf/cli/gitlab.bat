@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    goto help

:args
    goto end

:short
    echo Gitlab infrastructure for architecture demo.
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Control gitlab infrastructure for architecture demo.
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
