# Stress Test Docs

Para las pruebas de estrés se deben tener instaladas las dependencias de desarrollo. Esto con `poetry install`. Luego se deben seguir los siguientes pasos:
1. Ir al directorio `stress_test/` con `cd stress_test/`.
2. Ejecutar el comando `locust -f locustfile.py --host=https://jxpfxdzhui.execute-api.us-east-1.amazonaws.com/prd`. Esto levantará un servidor en el puerto 8089. Para acceder a la interfaz web, ir a `http://localhost:8089/`.
3. Acá se configurará la cantidad de usuarios y la tasa de llegada. Luego se presiona el botón `Start swarming`.
4. En configuraciones avanzadas se puede cambiar la duración del test.
5. Navegar por los reportes.

En [stress test report](https://raw.githubusercontent.com/Diego-II/challenge-neueralworks/main/docs/stress_test_report.html) se encuentra uno ejecutado a modo de prueba. 

Algunos comentarios sobre las pruebas de estres:
- La herramienta `wrk` no me funcionó. Tuve problemas con la cantidad de requests y el uso de CPU. Era poco amigable para las configuraciones.
- Por funcionamiento interno de AWS y cuotas de servicios, es difícil realmente testear este servicio. Después de un rato de pruebas, comienza a arrojar error 429 (too many requests) y 503 (service unavailable). Se intentó dejar con cuotas "absurdas" pero de todas formas esto sigue ocurriendo.
- Para realizar mejores pruebas, sería interesante usar una plataforma distribuida con distintas IPs. Locust permite esto. Pero no lo alcancé a implementar.
- Los resultados dependen de la conectividad. Estaba realizando pruebas en la comuna de Cunco, la conectividad es mala.
- Sobre como obtener mejores resultados, usualmente serverless con api gateway es bastante bueno. De todas formas, esto funciona porque el modelo es simple y liviano. Si no fuese así, se debiese implementar con servidores, un balanceador de carga, quizás colas de procesamiento.
- Una forma "simple" de mejorar el rendimiento es implementando un cache. Hay distintas formas de hacerlo, desde tablas en bases de datos hasta servicios de AWS. API Gateway tiene un cache que se puede configurar. Esto reduce la cantidad de llamadas a Lambda lo que aumenta la eficiencia.
- Se puede implementar un endpoint para predicciones batch. Gran parte del tiempo es en overhead de traer la imagen del ECR a Lambda y levantarla... si esto se aprovecha con varios datos a predecir puede aumentar la eficiencia. Pero esto no hace que pueda responder mas requests, solo hace que se deban hacer menos requests por usuario.
  