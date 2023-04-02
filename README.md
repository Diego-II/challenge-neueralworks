# challenge-neueralworks

Neuralworks challenge

## Algunos *disclaimers*:
- Tengo un error en el nombre del repo (y del paquete en python). Lo dejé así porque no creo que sea tan grave en este momento. Si alcanzo, hago las correcciones necesarias.
- Esta vez, los datos y los notebooks se almacenarán en el mismo repositorio... sé que no es la mejor práctica, pero estoy tratando de mantener las cosas simples.
- El código está escrito en Python 3.10.
- Se utiliza Poetry como gestor de dependencias y paquetes.
- La infraestructura esta en AWS.
- 

## Modelos:

Cada modelo en producción debe seguir algunas reglas:
1. El modelo debe estar almacenado en la direccion `models/<model_name>/some-name.joblib`
2. Para la serialización del modelo se utilizó joblib.


## Development:
Para pruebas en local de la API se debe tener Docker andando. 

```bash
docker build -t challenge:latest .
docker run -p 9000:8080  challenge:latest
```

Esto permite hacer solicitudes en el siguiente endpoint:
```bash
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```