# EuroElection-Trends

# Procesamiento de Datos Electorales

## Descripción General
Este script de Python procesa datos de elecciones europeas españolas desde archivos Excel (2014, 2019, 2024) e los importa a una base de datos MySQL con tablas para partidos, provincias, comunidades, elecciones, resultados, diputados y votantes.

## Funcionalidad del Script

### Conexión y Configuración de Base de Datos
- Establece conexión MySQL usando mysql.connector
- Crea cursor para ejecutar consultas SQL

### Procesamiento de Datos Excel
- Carga dinámicamente archivo Excel desde directorio `./data/`
- **Auto-detecta el año electoral desde el nombre del archivo** (ej. 2014.xlsx, 2019.xlsx, 2024.xlsx)
- Simplemente cambiar el nombre del archivo Excel y ejecutar el script para procesar diferentes años electorales
- Analiza hoja 'Provincias' con detección dinámica de encabezados
- Extrae nombres de partidos (fila 3) y siglas (fila 4) desde columna 16 en adelante

### Proceso de Importación de Datos

1. **Registro de Partidos**
   - Itera a través de nombres y siglas de partidos
   - Verifica partidos existentes para evitar duplicados
   - Inserta nuevos partidos en tabla Partido con nombre y siglas

2. **Creación de Registro Electoral**
   - Extrae año del nombre de archivo y establece tipo de elección como 'Europeas'
   - Crea o recupera registro electoral en tabla Elecciones

3. **Configuración de Estructura Geográfica**
   - Procesa filas 6+ para datos de comunidades y provincias
   - Crea estructura jerárquica: Comunidad → Provincia
   - Maneja relaciones padre-hijo entre comunidades y provincias

4. **Importación de Resultados de Votos**
   - Mapea cada combinación provincia-partido con conteos de votos
   - Convierte datos de votos a enteros, por defecto 0 para celdas vacías
   - Inserta resultados en tabla Resultados vinculando elecciones, provincias y partidos

5. **Asignación de Diputados**
   - Procesa última fila para conteos totales de diputados por partido
   - Inserta números agregados de diputados en tabla Diputados

6. **Estadísticas de Votantes**
   - Extrae datos comprehensivos de votantes: población, censo, mesas electorales, votos válidos, etc.
   - Maneja 15 métricas diferentes relacionadas con votantes por provincia
   - Inserta estadísticas detalladas de votación en tabla Votantes

### Manejo de Errores y Validación de Datos
- Implementa verificaciones de existencia antes de inserciones para prevenir duplicados
- Maneja valores NaN y tipos de datos inválidos de manera elegante
- Usa bloques try-catch para conversión robusta de datos

## Problemas Encontrados en la Estructura de Datos

### 1. Estructura Inconsistente de Columnas
- **Problema**: Columna "Solicitudes voto CERA aceptadas" faltante en archivo 2014 y vacía en 2019
- **Solución**: Se añadió columna faltante al archivo 2014 para mantener estructura consistente en todos los años

### 2. Limitación de Longitud de Nombres de Partidos
- **Problema**: Algunos nombres de partidos excedían el límite VARCHAR de 255 caracteres
- **Solución**: Esquema de base de datos modificado para acomodar nombres de partidos más largos

### 3. Siglas Inconsistentes de Partidos
- **Problema**: Los mismos partidos tenían diferentes siglas (ej. "PP" vs "P.P." para Partido Popular)
- **Solución**: Estandarización manual de siglas de partidos en todos los archivos antes del procesamiento

### 4. Gestión de Logos de Partidos
- **Problema**: Los logos de partidos necesitaban ser vinculados a registros de base de datos
- **Solución**: Adición manual de URLs de logos para cada entrada de partido