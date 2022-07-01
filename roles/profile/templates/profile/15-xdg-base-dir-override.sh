export HISTFILE="$XDG_STATE_HOME/bash_history"

export LESSHISTFILE="$XDG_STATE_HOME/lesshist"

export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export INPUTRC="$XDG_CONFIG_HOME/inputrc"

export COMPOSER_BIN_DIR="$HOME/.local/bin"

export KREW_ROOT="$XDG_DATA_HOME/krew"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

export GOPATH="$XDG_DATA_HOME/go"

export PSQL_HOME="$XDG_CONFIG_HOME/psql"
mkdir -p "$PSQL_HOME"
export PSQLRC="$PSQL_HOME/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PGPASSFILE="$PSQL_HOME/pgpass"
export PGSERVICEFILE="$PSQL_HOME/pg_service.conf"

export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export KDEHOME="$XDG_CONFIG_HOME/kde4"
