# Configuração básica para o tema Powerlevel10k
# Este arquivo contém apenas configurações essenciais recomendadas
# Para obter uma configuração completa, execute 'p10k configure' no terminal

# Opções essenciais do Powerlevel10k
# Estas são recomendações para o Windows Terminal + WSL

# Fontes e ícones
typeset -g POWERLEVEL9K_MODE=nerdfont-complete

# Configurações gerais
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION='❯'
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_CONTENT_EXPANSION='❯'
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VICMD_CONTENT_EXPANSION='❮'
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VICMD_CONTENT_EXPANSION='❮'

# Elementos do prompt esquerdo
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  # Os elementos abaixo são comuns e geralmente úteis
  os_icon                 # ícone do sistema operacional
  dir                     # diretório atual
  vcs                     # git status
  prompt_char             # caractere do prompt
)

# Elementos do prompt direito
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status                  # status do último comando
  command_execution_time  # tempo de execução do último comando
  background_jobs         # indicador de jobs em background
  time                    # hora atual
)

# Configuração do diretório
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true

# Configuração de cores para o diretório atual
typeset -g POWERLEVEL9K_DIR_FOREGROUND=254
typeset -g POWERLEVEL9K_DIR_BACKGROUND=4

# Status do último comando executado
typeset -g POWERLEVEL9K_STATUS_OK=false
typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=1
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=0

# Tempo de execução do comando
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=0

# Formatação do relógio
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'

# Dica: para criar uma configuração completa personalizada,
# execute 'p10k configure' e siga as instruções interativas.
