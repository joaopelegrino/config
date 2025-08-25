
# Diretrizes de Ferramentas de Desenvolvimento e Observabilidade

**Público-alvo:** Desenvolvedores Humanos e Agentes LLM
**Propósito:** Padronizar o uso do nosso ecossistema de ferramentas locais para garantir consistência, qualidade e eficiência no desenvolvimento e nos testes.

---

## 1. Filosofia e Visão Geral

As ferramentas configuradas no `.gemini/settings.json` e orquestradas via `docker-compose.yml` foram escolhidas com base nos seguintes princípios:

- **Padrão de Mercado e Open Source:** Utilizamos ferramentas líderes em suas categorias (Prometheus, Selenium, WireMock), que são amplamente documentadas e suportadas pela comunidade.
- **Ambiente Local e Consistente:** Tudo roda em contêineres Docker, garantindo que o ambiente de desenvolvimento seja idêntico para todos os membros da equipe e para os agentes de automação.
- **Pronto para Automação:** As ferramentas foram configuradas para serem facilmente controladas por scripts e agentes LLM, com APIs e estruturas de diretório claras.

## 2. Guia de Ferramentas

A seguir, o detalhamento de cada ferramenta, com diretrizes de uso para humanos e LLMs.

### 📊 Prometheus (`metrics-server`)

- **O que é?** Um sistema de monitoramento e alerta que coleta e armazena métricas como séries temporais.
- **Endpoint:** `http://localhost:9090`

#### Diretrizes para Humanos
- **Interface:** Acesse `http://localhost:9090` no seu navegador para usar a UI do Prometheus, explorar métricas e construir queries (PromQL).
- **Configuração:** O arquivo principal é `prometheus/prometheus.yml`. Adicione novos `scrape_configs` para que o Prometheus monitore novos serviços da sua aplicação.
- **Foco:** Use o Prometheus para monitorar a saúde do sistema (CPU, memória), performance da aplicação (latência, taxa de erros) e métricas de negócio.

#### Diretrizes para Agentes LLM
- **Assunção:** Você pode assumir que o servidor Prometheus está sempre disponível no endpoint configurado.
- **Leitura de Métricas:** Você pode fazer queries na API do Prometheus para obter dados. Exemplo de comando `curl`:
  ```bash
  curl 'http://localhost:9090/api/v1/query?query=up'
  ```
- **Análise de Configuração:** Para entender o que está sendo monitorado, você pode ler o arquivo de configuração em `./prometheus/prometheus.yml`.
- **Geração de Alertas:** Você pode ser solicitado a criar regras de alerta. Estas devem ser adicionadas a um arquivo de regras (e.g., `prometheus/rules.yml`) e referenciadas no `prometheus.yml`.

---

### 🎭 WireMock (`api-mocking`)

- **O que é?** Um simulador de APIs HTTP. Permite criar "stubs" de respostas para endpoints de API, simulando serviços externos.
- **Endpoint de Admin:** `http://localhost:8080/__admin`

#### Diretrizes para Humanos
- **Criação de Mocks:** A forma mais simples de criar mocks é adicionar arquivos JSON no diretório `wiremock/mappings`. Cada arquivo representa um stub de API.
- **Exemplo de Mock (`wiremock/mappings/exemplo.json`):
  ```json
  {
    "request": {
      "method": "GET",
      "url": "/api/exemplo"
    },
    "response": {
      "status": 200,
      "jsonBody": { "mensagem": "Olá, mundo!" },
      "headers": { "Content-Type": "application/json" }
    }
  }
  ```
- **Verificação:** Use a API de admin (`http://localhost:8080/__admin/requests`) para ver as requisições que o WireMock recebeu, o que é útil para depurar testes.

#### Diretrizes para Agentes LLM
- **Assunção:** O WireMock está sempre disponível e o diretório de mappings é `./wiremock/mappings`.
- **Criação de Mocks:** Sua principal tarefa será criar arquivos de mock em JSON e salvá-los no diretório `wiremock/mappings`. O WireMock carrega novos mocks automaticamente.
- **Geração de Cenários de Teste:** Você pode criar múltiplos arquivos de mock para simular diferentes cenários: respostas de sucesso, erros de servidor (500), erros de cliente (404), respostas com latência, etc.
- **Limpeza:** Você pode ser instruído a limpar os mocks após um teste, o que pode ser feito via API ou removendo os arquivos `.json`.

---

### 🌐 Selenium Grid (`browser-automation`)

- **O que é?** Uma ferramenta para automação de testes de interface de usuário em navegadores. O Grid permite executar testes em paralelo em diferentes browsers.
- **Endpoint do Hub:** `http://localhost:4444/wd/hub`

#### Diretrizes para Humanos
- **Escrita de Testes:** Escreva seus testes de UI usando sua biblioteca de cliente Selenium preferida (para Python, Java, JavaScript, etc.). Configure o cliente para se conectar ao `RemoteWebDriver` no endpoint do Hub.
- **Interface do Grid:** Acesse `http://localhost:4444` para ver a interface do Selenium Grid, onde você pode ver os nós (browsers) disponíveis e as sessões em execução.
- **Seletores:** Dê preferência a seletores robustos e focados em atributos de teste, como `data-testid`, em vez de seletores frágeis como XPath.

#### Diretrizes para Agentes LLM
- **Assunção:** O Selenium Grid está disponível com nós Chrome e Firefox prontos para uso.
- **Geração de Código de Teste:** Sua principal tarefa será gerar scripts de teste (e.g., em Python com `selenium`) que usem o `RemoteWebDriver` para se conectar ao Hub.
- **Exemplo de Conexão (Python):
  ```python
  from selenium import webdriver

  options = webdriver.ChromeOptions()
  driver = webdriver.Remote(
      command_executor='http://localhost:4444/wd/hub',
      options=options
  )
  driver.get("http://example.com")
  print(driver.title)
  driver.quit()
  ```
- **Análise de Resultados:** Você pode ser solicitado a analisar os resultados dos testes, que geralmente são gerados por um framework de teste como PyTest ou Jest.

---

## 3. Como Começar

1.  **Pré-requisitos:** Docker e Docker Compose instalados.
2.  **Estrutura:** Crie os diretórios `prometheus` e `wiremock/mappings` no seu workspace.
3.  **Configuração:** Adicione um arquivo `prometheus.yml` básico no diretório `prometheus`.
4.  **Execução:** Rode `docker compose up -d` na raiz do workspace.

## 4. Nota sobre o ELK Stack

O **ELK Stack** (Elasticsearch, Logstash, Kibana) foi configurado no `settings.json` como o `log-aggregator`, mas **não foi incluído** no `docker-compose.yml` por padrão. A razão é que esta é uma stack de serviços pesada que consome uma quantidade significativa de recursos (RAM e CPU).

- **Quando usar?** Se o seu projeto demanda análise e visualização complexa de logs.
- **Como usar?** Recomenda-se seguir o [guia oficial do Elastic](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-docker.html) para uma instalação e configuração adequadas.
