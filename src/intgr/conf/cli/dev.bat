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
    @rem Declare variable by .gitrc file
    call :parser-gitrc

    @rem Retrieve integrate target repository information
    if exist %CLI_DIRECTORY%\app\.intgrrc (
        @rem find repository in .intgrrc file
        for /f "tokens=1,2 delims=$" %%i in ('findstr /i /c:"$" %CLI_DIRECTORY%\app\.intgrrc') do (
            @rem retrieve repository name, path, operation
            set REPO_NAME=%%i
            for /f "tokens=1,2 delims=@" %%x in ("%%j") do (
                set REPO_OP=%%x
                set REPO_PATH=%%y
                if not defined REPO_PATH (
                    set REPO_PATH=%%x
                    set REPO_OP=
                )
            )

            @rem execute repository base on parameter
            call :execute-repo !REPO_NAME! !REPO_PATH! !REPO_OP!
        )
    ) else (
        echo %CLI_DIRECTORY%\app\.intgrrc not find.
    )
    goto end

:args
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
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:parser-gitrc
    if exist %CLI_DIRECTORY%\app\.gitrc (
        for /f "tokens=1" %%i in ('findstr /i /c:"=" %CLI_DIRECTORY%\app\.gitrc') do (set "%%i")
        if defined GIT_SERVER (echo GIT_SERVER=!GIT_SERVER!)
        if defined GIT_ACCESS_NAME (echo GIT_ACCESS_NAME=!GIT_ACCESS_NAME!)
        if defined GIT_ACCESS_TOKEN (echo GIT_ACCESS_TOKEN=!GIT_ACCESS_TOKEN!)
    ) else (
        echo %CLI_DIRECTORY%\app\.gitrc not find.
    )
    goto end

:parser-repo-operation
    for /f "tokens=1* delims=:" %%x in ("%1") do (
        if not defined REPO_OP_LOC (
            if "%%x"=="GIT" (set REPO_OP_LOC=%%x)
            if "%%x"=="LOC" (set REPO_OP_LOC=%%x)
        )
        if not defined REPO_OP_ENV (
            if "%%x"=="DEV" (set REPO_OP_ENV=%%x)
            if "%%x"=="PRD" (set REPO_OP_ENV=%%x)
        )
        call :parser-repo-operation %%y
    )
    goto end

:execute-repo
    @rem Declare variable
    set REPO_NAME=%1
    set REPO_PATH=%2
    set REPO_OP_LOC=
    set REPO_OP_ENV=

    @rem parser operation
    call :parser-repo-operation %3
    if not defined REPO_OP_LOC (set REPO_OP_LOC=LOC)
    if not defined REPO_OP_ENV (set REPO_OP_ENV=PRD)

    @rem Show information
    echo ^Repository : %REPO_NAME%
    echo ^-- Git Path: %REPO_PATH%
    echo ^-- Source Directory : %REPO_OP_LOC%
    echo ^-- DevOps Environment : %REPO_OP_ENV%

    @rem setting source directory.
    cd %CLI_DIRECTORY%..
    set REPO_ROOT_DIR=%CD%
    if "%REPO_OP_LOC%"=="GIT" (set REPO_ROOT_DIR=%CLI_DIRECTORY%cache\git)
    if not exist %REPO_ROOT_DIR% (mkdir %REPO_ROOT_DIR%)

    @rem find repository with name
    set REPO_DIR=%REPO_ROOT_DIR%\%REPO_NAME%
    if not exist %REPO_DIR% (
        @rem repository not find, call git clone.
        echo %REPO_NAME% not find in %REPO_ROOT_DIR%
    )

    @rem find repository and devops CLI fine.
    if exist %REPO_DIR% (
        cd %REPO_DIR%
        if not exist cli.bat (
            echo %REPO_NAME% not find devops command-line interface 'cli.bat'.
        ) else (
            dir cli.bat
            if "%REPO_OP_ENV%"=="DEV" (
                echo Call develop mode
            )
            if "%REPO_OP_ENV%"=="PRD" (
                echo Call publish mode
            )

        )
        cd %CLI_DIRECTORY%
    )

    @rem echo a new line.
    echo.

    goto end

:end
