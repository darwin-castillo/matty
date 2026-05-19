# Matty - Aprende las Tablas de Multiplicar

Una aplicación móvil desarrollada en Flutter para ayudar a los niños a memorizar las tablas de multiplicar de forma interactiva y divertida.

## Características

- **Modo Quiz**: Practica operaciones de multiplicación con retroalimentación inmediata
- **Tabla del 2**: Comeienza con la tabla del 2 (expandible a otras tablas)
- **Operaciones Aleatorias**: Multiplicadores del 1 al 9 en orden aleatorio
- **4 Opciones de Respuesta**: Selección múltiple con respuestas distractoras
- **Seguimiento de Progreso**: Contador de respuestas correctas e incorrectas
- **Feedback Visual**: Indicadores visuales de acierto/error

## Arquitectura

El proyecto sigue los principios de **Clean Architecture** con separación en capas:

```
lib/
├── core/                    # Componentes compartidos
│   ├── error/              # Manejo de errores
│   └── usecases/           # Casos de uso base
└── features/multiplication/
    ├── domain/             # Lógica de negocio
    │   ├── entities/      # Entidades del dominio
    │   ├── repositories/ # Interfaces de repositorio
    │   └── usecases/      # Casos de uso específicos
    ├── data/              # Implementaciones
    │   └── repositories/  # Repositorios concretos
    └── presentation/       # Interfaz de usuario
        ├── providers/     # Estado con Riverpod
        └── pages/        # Widgets y páginas
```

## Estado

**Riverpod** se utiliza como gestor de estado:
- `MultiplicationState`: Estado global de la aplicación
- `MultiplicationNotifier`: Notificador para modificar el estado
- Providers para inyectar dependencias (repositorio, casos de uso)

## Tecnologías

- **Flutter** 3.11+
- **flutter_riverpod** 2.5+ - Gestión de estado
- **equatable** 2.0+ - Comparación de objetos

## Ejecución

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en emulator/simulador
flutter run

# Ejecutar tests
flutter test
```

## Estructura de la UI

1. **Barra de puntuación**: Muestra aciertos (✓) y errores (✗)
2. **Pregunta central**: Operacion grande (ej: 2 × 5)
3. **Grid de respuestas**: 4 botones con posibles respuestas
4. **Botón siguiente**: Aparece después de responder

## Expansión Futura

- [ ] Seleccionar diferentes tablas (1-10)
- [ ] Modo aprendizaje con todas las respuestas
- [ ] Temporizador
- [ ] Historial de sesiones
- [ ] Niveles de dificultad