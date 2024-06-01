@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    docker exec -ti %PROJECT_NAME%-infra-gitlab bash 0-initial-account.sh
    docker exec -ti %PROJECT_NAME%-infra-gitlab bash 1-initial-group-and-user.sh
    docker exec -ti %PROJECT_NAME%-infra-gitlab bash 2-initial-projects.sh
    goto end

:args
    goto end

:short
    echo Initial service.
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Initial gitlab service account, group, user, projects.
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
