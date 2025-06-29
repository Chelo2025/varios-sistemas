# 🛡️ Auditoría automatica de actualizaciones en Linux

Un script en Bash para entornos Linux y permite realizar auditoría, instalación de parches y control de cambios en servidores linux.

Fue ejecutado en **servidores Debian 12 sin entorno gráfico**.

---

## 🚀 ¿Qué hace este script?

🔍 Detecta automáticamente la distribución Linux.
🔄 Ejecuta actualizaciones del sistema según el gestor de paquetes compatible.
🧾 Genera informes ".txt" por fecha con lo que se actualizó y cambios recientes en "/etc".
♻️ Conserva los últimos 10 informes automáticamente.
⏰ Pensado para ejecutarse desde "cron" todos los sábados.

## 💻 Probado en

 ✅ Debian 12 (sin interfaz gráfica)
Acceso como **usuario root**
También compatible con:
Ubuntu
CentOS 7 / RHEL (usa "yum")
CentOS 8 / Fedora / RHEL moderno (usa "dnf")
Arch Linux


## 🛠️ Instalación y uso (seguimos como usuario root)

### 1. Actualizar paquetes e instalar Git 
apt update && apt install git -y

### 2. Clonar el repositorio e ingresar a ese directorio

git clone https://github.com/Chelo2025/varios-sistemas

cd varios-sistemas

### 3. Asignar permisos de ejecución y ejecutar script manualmente para verificar errores

chmod +x actualizaciones.sh

./actualizaciones.sh

### 4. Copiar el script al sistema

cp actualizaciones.sh /usr/local/bin/

### 5. Agregar al crontab para que se ejecute todos los sábados

crontab -e

Agregar esta línea (puede ser al final)

0 2 * * 6 /usr/local/bin/actualizaciones.sh


## 📋 Salida esperada del script

Informe de Actualizaciones - 28-jun-25
Distribución detectada: debian
-------------------------------------------
Actualizando índices de paquetes.
...

Actualizaciones disponibles:
...

Aplicando actualizaciones.
...

Archivos modificados en /etc (últimas 24h):
...


## 👨‍💻 Autor

### Marcelo Martinez - Chelo2025

🎓 Estudiante de Licenciatura en Tecnologías Digitales

🛡️ Técnico Superior en Redes Informáticas

🎓 Estudiante en Diplomado en Administración de Redes Linux, Ciberseguridad y Hacking Ético

🔗 GitHub: https://github.com/Chelo2025