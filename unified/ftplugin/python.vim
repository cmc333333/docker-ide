set softtabstop=4
set shiftwidth=4
set textwidth=88 "Per black
set foldmethod=syntax

let b:ale_linters = ["black", "flake8", "isort", "mypy", "pyls"]
let b:ale_fixers = ["black", "isort", "remove_trailing_lines", "trim_whitespace"]
let b:ale_python_pyls_config = {"pyls": {"configurationSources": ["flake8"] } }
