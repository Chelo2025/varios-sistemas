#!/bin/bash
# 🛡️ Script profesional de auditoría y aplicación de actualizaciones
# 👨‍💻 Me gustan los emojis
# 💡 Ejecutar con permisos de root
# 📁 Guarda informes por fecha y mantiene rotación de logs (últimos 10)

# 📂 Ruta donde se almacenan los informes de actualización
DIR_LOG="/var/log/mis_actualizaciones"
mkdir -p "$DIR_LOG"

# 📅 Formato de fecha: 28-jun-25
FECHA=$(date +'%d-%b-%y' | tr '[:upper:]' '[:lower:]')
ARCHIVO_LOG="$DIR_LOG/actualizaciones_${FECHA}.txt"

# 🔎 Detección de la distribución
DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')

# 📦 Definición de comandos según distribución
case "$DISTRO" in
  ubuntu|debian)
    ACTUALIZAR="apt-get update"
    DISPONIBLES="apt list --upgradable"
    APLICAR="apt-get upgrade -y"
    LISTAR_INSTALADAS="apt-mark showmanual"
    ;;
  centos|rhel)
    # CentOS 7 y RHEL 7 usan yum
    if command -v yum >/dev/null; then
      ACTUALIZAR="yum check-update || true"
      DISPONIBLES="yum list updates || true"
      APLICAR="yum update -y"
      LISTAR_INSTALADAS="yum list installed"
    else
      # Versiones más recientes usan dnf
      ACTUALIZAR="dnf check-update || true"
      DISPONIBLES="dnf list updates || true"
      APLICAR="dnf upgrade -y"
      LISTAR_INSTALADAS="dnf list installed"
    fi
    ;;
  fedora)
    ACTUALIZAR="dnf check-update || true"
    DISPONIBLES="dnf list updates || true"
    APLICAR="dnf upgrade -y"
    LISTAR_INSTALADAS="dnf list installed"
    ;;
  arch)
    ACTUALIZAR="pacman -Sy"
    DISPONIBLES="pacman -Qu || true"
    APLICAR="pacman -Su --noconfirm"
    LISTAR_INSTALADAS="pacman -Qe"
    ;;
  *)
    echo "Distribución no soportada: $DISTRO" > "$ARCHIVO_LOG"
    exit 1
    ;;
esac

# 📝 Generación del informe
{
  echo "Informe de Actualizaciones"
  echo "Distribución detectada: $DISTRO"
  echo "Fecha del análisis: $FECHA"
  echo "-------------------------------------------"

  echo "Actualizando índices de paquetes."
  eval "$ACTUALIZAR"

  echo ""
  echo "Actualizaciones disponibles:"
  eval "$DISPONIBLES"

  echo ""
  echo "Aplicando actualizaciones."
  eval "$APLICAR"

  echo ""
  echo "Paquetes instalados tras la actualización:"
  eval "$LISTAR_INSTALADAS"

  echo ""
  echo "Archivos modificados en /etc (últimas 24h):"
  find /etc -type f -mtime -1 2>/dev/null
} > "$ARCHIVO_LOG"

# ♻️ Mantenimiento: conservar solo los últimos 10 archivos
cd "$DIR_LOG"
ls -1tr actualizaciones_*.txt | head -n -10 | xargs -r rm -f
