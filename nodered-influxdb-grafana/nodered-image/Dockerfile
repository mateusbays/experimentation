# Imagem customizada do Node-RED com o palette node-red-contrib-influxdb
FROM nodered/node-red:latest

# Instala o node do palette desejado
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production node-red-contrib-influxdb

# Copia script de inicialização que remove flows_cred.json
COPY start.sh /usr/local/bin/start-nodered.sh
RUN chmod +x /usr/local/bin/start-nodered.sh

# Usa o script como entrypoint/cmd
CMD ["/usr/local/bin/start-nodered.sh"]
