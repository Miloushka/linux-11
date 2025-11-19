#!/bin/sh
### BEGIN INIT INFO
# Provides: esme-gpio26-toggle
# Required-Start: $remote_fs $time
# Required-Stop: $remote_fs $time
# Default-Start: 3 4 5
# Default-Stop: 0 1 2 6
# Short-Description: ESME GPIO#26 toggle service
### END INIT INFO

DAEMON="/usr/bin/gpio"
PIDFILE="/var/run/esme-gpio26-toggle.pid"

case "$1" in
  start)
    echo "Starting $NAME..."
    start-stop-daemon --start --background --make-pidfile --pidfile "$PIDFILE" --exec "$DAEMON"
    ;;

  stop)
    echo "Stopping $NAME..."
    start-stop-daemon --stop --pidfile "$PIDFILE" --retry=TERM/5/KILL/5
    ;;

  restart)
    "$0" stop
    "$0" start
    ;;

  status)
    if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
      echo "Status of esme-gpio-toggle for GPIO#26: running with PID=$(cat $PIDFILE)"
    else
      echo "Status of esme-gpio-toggle for GPIO#26: stopped"
    fi
    ;;

  *)
    echo "Usage : esme-gpio26-toggle (start | stop | restart | status )"
    exit 1
    ;;
esac
