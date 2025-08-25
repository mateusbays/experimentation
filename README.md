# SCADA Simulation: Node-RED + InfluxDB + Grafana

Este projeto levanta um ambiente Docker com Node-RED, InfluxDB 2.x e Grafana para simular um sistema SCADA de vibração.

## Como subir o ambiente

1) Suba os containers:
   docker compose up -d

2) Acesse:
- Node-RED: http://localhost:1880
- InfluxDB: http://localhost:8086
- Grafana:   http://localhost:3000 (login padrão: admin / admin)

## Importante: configurar o Token no Node-RED (InfluxDB Out)

Para que o Node-RED consiga escrever no InfluxDB, você deve configurar o Token no nó de saída do InfluxDB (InfluxDB Out) que envia os dados.

- Token a ser utilizado: mytoken123456789
- Organization (org): myorg
- Bucket: mybucket
- Measurement (no fluxo): scada_data

Passo a passo no Node-RED:
1. Abra o editor Node-RED em http://localhost:1880
2. No fluxo "SCADA Simulator", localize o nó InfluxDB Out (ou o nó de configuração InfluxDB vinculado a ele).
3. Edite o nó e selecione InfluxDB 2.0 como versão (quando aplicável).
4. Configure:
   - URL: http://influxdb:8086
   - Organization: myorg
   - Token: mytoken123456789
   - Bucket: mybucket
5. Clique em Update/Done e depois em Deploy.

Dicas:
- Se o nó InfluxDB Out estiver referenciando um nó de configuração InfluxDB (node de tipo "influxdb"), edite esse nó de configuração e informe o Token acima.
- Verifique os logs do InfluxDB em caso de erro de autorização.

## Grafana

- O datasource do Grafana já está provisionado para usar o bucket mybucket e a org myorg, com autenticação via token.
- O dashboard principal de vibração é provisionado com o UID: vibration-dashboard.

## Teste rápido de escrita no InfluxDB (opcional)

Você pode inserir um ponto de teste diretamente via API:

curl -s -XPOST "http://localhost:8086/api/v2/write?org=myorg&bucket=mybucket&precision=ns" \
  -H "Authorization: Token mytoken123456789" \
  -H "Content-Type: text/plain; charset=utf-8" \
  --data-binary "scada_data,machine=motor1 motor1_vibration_overall=3.2 $(date +%s%N)"

## Reiniciar serviços

- Reiniciar apenas o Grafana (para reprovisionar dashboards/datasources):
  docker compose restart grafana

- Derrubar todo o ambiente:
  docker compose down
