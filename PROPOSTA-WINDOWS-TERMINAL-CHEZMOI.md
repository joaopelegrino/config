# Proposta: Integrar Windows Terminal no Chezmoi

**Data:** 2025-10-22
**Status:** Proposta para Implementação
**Prioridade:** Alta (Antes da Limpeza Geral)

---

## 🎯 Objetivo

Gerenciar as configurações do Windows Terminal através do chezmoi, permitindo:
- ✅ Versionamento das configurações
- ✅ Sincronização entre máquinas
- ✅ Backup automático
- ✅ Aplicação consistente via `chezmoi apply`

---

## 📍 Localização Atual

### No Windows
```
C:\Users\valor\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
```

### No WSL (equivalente)
```
/mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
```

### No Repositório Chezmoi (atual)
```
/home/notebook/.local/share/chezmoi/windows-terminal-settings.json
```
- **Status:** ❌ Arquivo existe mas **NÃO está gerenciado** pelo chezmoi
- **Problema:** Não é aplicado automaticamente com `chezmoi apply`

---

## 🏗️ Proposta de Implementação

### Opção 1: Symlink via Script (RECOMENDADA) ⭐

**Vantagens:**
- ✅ Funciona perfeitamente com WSL2
- ✅ Mantém arquivo Windows sincronizado automaticamente
- ✅ Suporta templating do chezmoi
- ✅ Permite variáveis dinâmicas (username, paths)

**Estrutura:**
```
~/.local/share/chezmoi/
├── dot_config/
│   └── windows-terminal/
│       └── settings.json.tmpl     # Template com variáveis
└── run_once_before_setup-windows-terminal.sh.tmpl  # Script de setup
```

**Implementação:**

#### 1. Criar arquivo template
**Arquivo:** `dot_config/windows-terminal/settings.json.tmpl`
```json
{{- /* Windows Terminal Settings Template */ -}}
{{- /* User: {{ .chezmoi.username }} */ -}}
{{- /* OS: {{ .chezmoi.os }} */ -}}
{
    "$help": "https://aka.ms/terminal-documentation",
    "$schema": "https://aka.ms/terminal-profiles-schema",

    {{- /* Configurações gerais */ -}}
    "defaultProfile": "{51855cb2-8cce-5362-8f54-464b92b32386}",
    "copyOnSelect": true,
    "copyFormatting": "none",
    "centerOnLaunch": true,

    {{- /* ... resto das configurações ... */ -}}
}
```

#### 2. Criar script de setup
**Arquivo:** `run_once_before_setup-windows-terminal.sh.tmpl`
```bash
#!/bin/bash
# Setup Windows Terminal settings via chezmoi

{{- if eq .chezmoi.os "linux" }}
{{- if (.chezmoi.kernel.osrelease | lower | contains "microsoft") }}

echo "🔧 Setting up Windows Terminal integration..."

# Definir caminhos
WINDOWS_USER="{{ .windows_username }}"
WT_PATH="/mnt/c/Users/${WINDOWS_USER}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
CHEZMOI_WT_CONFIG="{{ .chezmoi.homeDir }}/.config/windows-terminal/settings.json"

# Verificar se Windows Terminal está instalado
if [ ! -d "$WT_PATH" ]; then
    echo "⚠️  Windows Terminal não encontrado em: $WT_PATH"
    echo "   Ignorando setup..."
    exit 0
fi

# Fazer backup do settings.json atual
if [ -f "$WT_PATH/settings.json" ]; then
    BACKUP_FILE="$WT_PATH/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Criando backup: $BACKUP_FILE"
    cp "$WT_PATH/settings.json" "$BACKUP_FILE"
fi

# Criar symlink do chezmoi para Windows Terminal
echo "🔗 Criando symlink..."
ln -sf "$CHEZMOI_WT_CONFIG" "$WT_PATH/settings.json"

echo "✅ Windows Terminal configurado!"
echo "   Configurações gerenciadas por: $CHEZMOI_WT_CONFIG"
echo "   Aplicadas em: $WT_PATH/settings.json"

{{- else }}
echo "⚠️  Não detectado WSL2, ignorando setup Windows Terminal"
{{- end }}
{{- else }}
echo "⚠️  OS não é Linux, ignorando setup Windows Terminal"
{{- end }}
```

#### 3. Adicionar variável ao chezmoi.toml
**Arquivo:** `.chezmoi.toml.tmpl`
```toml
{{- $windows_username := "valor" -}}
{{- if hasKey . "windows_username" -}}
{{-   $windows_username = .windows_username -}}
{{- else if stdinIsATTY -}}
{{-   $windows_username = promptString "Windows username" $windows_username -}}
{{- end -}}

[data]
    windows_username = {{ $windows_username | quote }}
```

---

### Opção 2: Copy Manual (Menos Recomendada)

**Estrutura:**
```
~/.local/share/chezmoi/
└── private_AppData/
    └── Local/
        └── Packages/
            └── Microsoft.WindowsTerminal_8wekyb3d8bbwe/
                └── LocalState/
                    └── settings.json.tmpl
```

**Problemas:**
- ❌ Chezmoi não gerencia naturalmente caminhos Windows do WSL
- ❌ Requer modificação de `modify_` scripts
- ❌ Mais complexo de manter

---

## 📋 Plano de Implementação Passo-a-Passo

### Etapa 1: Backup e Preparação
```bash
cd /home/notebook/.local/share/chezmoi

# 1. Fazer backup do settings atual do Windows Terminal
powershell.exe -Command "Copy-Item \$env:LOCALAPPDATA\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settings.json \$env:LOCALAPPDATA\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settings.json.backup.$(date +%Y%m%d)"

# 2. Copiar settings atual para estrutura chezmoi
mkdir -p dot_config/windows-terminal
cp windows-terminal-settings.json dot_config/windows-terminal/settings.json.tmpl
```

### Etapa 2: Criar Template com Variáveis

Editar `dot_config/windows-terminal/settings.json.tmpl` e adicionar variáveis dinâmicas:

```json
{
    "defaultProfile": "{{ .wsl_profile_guid }}",
    "profiles": {
        "defaults": {
            "font": {
                "face": "MesloLGS NF",
                "size": 11
            }
        },
        "list": [
            {
                "guid": "{{ .wsl_profile_guid }}",
                "name": "Ubuntu-24.04 ({{ .chezmoi.username }})",
                "source": "Windows.Terminal.Wsl",
                "startingDirectory": "//wsl.localhost/Ubuntu-24.04/home/{{ .chezmoi.username }}"
            }
        ]
    }
}
```

### Etapa 3: Criar Script de Setup

Criar `run_once_before_setup-windows-terminal.sh.tmpl` com o conteúdo mostrado na Opção 1.

### Etapa 4: Atualizar .chezmoi.toml.tmpl

Adicionar prompts para variáveis Windows Terminal:

```toml
{{- $windows_username := "valor" -}}
{{- $wsl_profile_guid := "{51855cb2-8cce-5362-8f54-464b92b32386}" -}}

{{- if stdinIsATTY -}}
{{-   $windows_username = promptString "Windows username" $windows_username -}}
{{-   $wsl_profile_guid = promptString "WSL Profile GUID" $wsl_profile_guid -}}
{{- end -}}

[data]
    windows_username = {{ $windows_username | quote }}
    wsl_profile_guid = {{ $wsl_profile_guid | quote }}
```

### Etapa 5: Testar Aplicação

```bash
# 1. Re-init chezmoi (responder prompts)
chezmoi init

# 2. Ver o que será aplicado (dry-run)
chezmoi apply --dry-run --verbose

# 3. Aplicar mudanças
chezmoi apply

# 4. Verificar symlink
ls -la /mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
```

### Etapa 6: Remover Arquivo Legado

```bash
# Após confirmar que tudo funciona
cd /home/notebook/.local/share/chezmoi
rm windows-terminal-settings.json

# Adicionar ao .chezmoiignore se necessário
echo "windows-terminal-settings.json" >> .chezmoiignore
```

---

## 🎨 Funcionalidades Avançadas

### 1. Profiles Dinâmicos por Máquina

Usar templates para diferentes máquinas:

```json
{{- if eq .chezmoi.hostname "laptop-trabalho" }}
{
    "profiles": {
        "list": [
            {
                "name": "Work WSL",
                "colorScheme": "One Half Dark"
            }
        ]
    }
}
{{- else }}
{
    "profiles": {
        "list": [
            {
                "name": "Personal WSL",
                "colorScheme": "Campbell"
            }
        ]
    }
}
{{- end }}
```

### 2. Temas por Ambiente

```json
{
    "schemes": [
        {{- if .is_work_machine }}
        {
            "name": "Work Theme",
            "background": "#1E1E1E",
            "foreground": "#D4D4D4"
        }
        {{- else }}
        {
            "name": "Personal Theme",
            "background": "#0C0C0C",
            "foreground": "#CCCCCC"
        }
        {{- end }}
    ]
}
```

### 3. Script de Atualização Manual

Criar `scripts/update-windows-terminal.sh`:
```bash
#!/bin/bash
# Atualiza settings do Windows Terminal forçadamente

CHEZMOI_WT="{{ .chezmoi.homeDir }}/.config/windows-terminal/settings.json"
WT_PATH="/mnt/c/Users/{{ .windows_username }}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

echo "🔄 Atualizando Windows Terminal settings..."
cp "$CHEZMOI_WT" "$WT_PATH"
echo "✅ Atualizado!"
```

---

## 🔒 Considerações de Segurança

### Informações Sensíveis

**Não incluir no template:**
- Paths absolutos com usernames pessoais (usar variáveis)
- Credenciais ou tokens
- Informações de rede corporativa

**Usar `.chezmoiignore` para:**
```
# Arquivos temporários Windows Terminal
**/*.backup.*
**/settings.json.old
```

---

## 📊 Comparação: Antes vs Depois

### ❌ Antes (Situação Atual)
```
Arquivo: windows-terminal-settings.json
Localização: Raiz do chezmoi
Status: Não gerenciado
Aplicação: Manual (copiar/colar)
Versionamento: Sim (mas não aplicado)
Templating: Não
Backup: Manual
```

### ✅ Depois (Com Integração)
```
Arquivo: dot_config/windows-terminal/settings.json.tmpl
Localização: Estrutura organizada
Status: Gerenciado pelo chezmoi
Aplicação: Automática (chezmoi apply)
Versionamento: Sim (com histórico)
Templating: Sim (variáveis dinâmicas)
Backup: Automático (script)
```

---

## 🎯 Benefícios da Integração

1. **Consistência:** Mesmas configurações em todas as máquinas
2. **Versionamento:** Histórico completo de mudanças
3. **Automação:** `chezmoi apply` aplica tudo
4. **Templating:** Variáveis para diferentes ambientes
5. **Backup:** Backups automáticos antes de aplicar
6. **Documentação:** Settings explicados com comentários
7. **Segurança:** Variáveis sensíveis separadas

---

## 📝 Próximos Passos Recomendados

### Fase 1: Setup Inicial (30min)
1. ✅ Backup atual do Windows Terminal
2. ✅ Criar estrutura `dot_config/windows-terminal/`
3. ✅ Mover e converter para template
4. ✅ Criar script `run_once_before_setup-windows-terminal.sh.tmpl`

### Fase 2: Configuração (15min)
5. ✅ Adicionar variáveis ao `.chezmoi.toml.tmpl`
6. ✅ Testar com `chezmoi apply --dry-run`
7. ✅ Aplicar e verificar

### Fase 3: Limpeza (5min)
8. ✅ Remover `windows-terminal-settings.json` da raiz
9. ✅ Atualizar documentação
10. ✅ Commit das mudanças

### Fase 4: Documentação (10min)
11. ✅ Atualizar README.md com instruções Windows Terminal
12. ✅ Adicionar seção no CLAUDE.md
13. ✅ Criar exemplo de customização

---

## 🚀 Comando Rápido de Implementação

```bash
# Executar tudo de uma vez (após revisar)
cd /home/notebook/.local/share/chezmoi

# 1. Criar estrutura
mkdir -p dot_config/windows-terminal

# 2. Mover arquivo
mv windows-terminal-settings.json dot_config/windows-terminal/settings.json.tmpl

# 3. Criar script de setup (criar arquivo manualmente ou via cat)
cat > run_once_before_setup-windows-terminal.sh.tmpl << 'EOFSCRIPT'
#!/bin/bash
# [Conteúdo do script da Opção 1]
EOFSCRIPT

chmod +x run_once_before_setup-windows-terminal.sh.tmpl

# 4. Testar
chezmoi apply --dry-run --verbose
```

---

## ❓ FAQ

### P: O symlink funciona com Windows Terminal?
**R:** Sim! Windows Terminal no Windows pode seguir symlinks criados pelo WSL.

### P: E se eu quiser settings diferentes por máquina?
**R:** Use templates com condicionais baseados em `{{ .chezmoi.hostname }}` ou crie variáveis específicas.

### P: Posso ter backup do settings anterior?
**R:** Sim! O script cria backup automático com timestamp antes de aplicar.

### P: Como reverter se algo der errado?
**R:** Restaure do backup: `cp settings.json.backup.* settings.json`

### P: Funciona com Windows Terminal Preview?
**R:** Sim, basta ajustar o path para `Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe`

---

## 📚 Referências

- [Chezmoi Docs - Templates](https://www.chezmoi.io/user-guide/templating/)
- [Windows Terminal Docs](https://learn.microsoft.com/windows/terminal/)
- [Chezmoi + WSL Best Practices](https://www.chezmoi.io/user-guide/machines/windows/)

---

**Criado por:** Claude Code
**Baseado em:** Análise do ambiente WSL2 + Windows Terminal 1.19.10821.0
**Status:** Pronto para Implementação
