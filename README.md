# Sistema de Gestión de Clínicas

Este repositorio contiene el código fuente para un sistema de gestión de clínicas desarrollado en Oracle Database. La aplicación gestiona información relacionada con pacientes, médicos, historias clínicas, citas, horarios y administradores.

## Estructura del Proyecto

- **Scripts SQL**: Contiene los scripts necesarios para crear las tablas, procedimientos almacenados, desencadenadores (triggers), secuencias y vistas en la base de datos Oracle.

- **Queries**: Incluye consultas de ejemplo para realizar operaciones comunes en la base de datos.

## Tablas Principales

1. **Patients**: Almacena información sobre los pacientes, incluyendo detalles como nombre, género, fecha de nacimiento, etc.

2. **Medics**: Contiene datos de los médicos, como matrícula, especialidad, estado, etc.

3. **Appointments**: Gestiona las citas médicas entre pacientes y médicos.

4. **Schedule**: Guarda información sobre los horarios de trabajo de los médicos.

5. **Admins**: Almacena datos de los administradores del sistema.

6. **Symptoms**: Contiene información sobre los síntomas relacionados con las historias clínicas.

## Procedimientos Almacenados

- **Procedimientos para pacientes y médicos**: Incluye funciones para agregar, actualizar y eliminar registros de pacientes y médicos.

- **Desencadenadores (Triggers)**: Aseguran consistencia en los datos, como el control de síntomas en las historias clínicas.

## Vistas

Proporciona vistas predefinidas para facilitar la recuperación de datos, como la información de las historias clínicas y citas.

## Uso

1. Clone este repositorio en su entorno de desarrollo Oracle Database.

2. Ejecute los scripts SQL para configurar la base de datos.

3. Utilice las queries de ejemplo para realizar operaciones en la base de datos.

¡Gracias por usar este sistema de gestión de clínicas! Siéntete libre de realizar mejoras y contribuir al proyecto.
