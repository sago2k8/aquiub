#! /bin/sh

PUMA_CONFIG_FILE=/var/www/aquiub/current/config/puma.rb
PUMA_PID_FILE=/var/www/aquiub/shared/pids/puma.pid
PUMA_STATE=/var/www/aquiub/shared/pids/puma.state
PUMA_SOCKET=/var/www/aquiub/shared/sockets/puma.sock


# check if puma process is running
puma_is_running() {
  if [ -S $PUMA_SOCKET ] ; then
    if [ -e $PUMA_PID_FILE ] ; then
      if cat $PUMA_PID_FILE | xargs ps -p  > /dev/null ; then
        return 0
      else
        echo "No puma process found"
      fi
    else
      echo "No puma pid file found"
    fi
  else
    echo "No puma socket found"
  fi

  return 1
}

case "$1" in
  start)
    echo "Starting puma..."
      if [ -e $PUMA_SOCKET ] ; then # if socket exists
        rm -f $PUMA_SOCKET
        echo "removed  $PUMA_SOCKET"
      fi
      if [ -e $PUMA_CONFIG_FILE ] ; then
         /bin/bash --login -c  "bundle exec puma -C $PUMA_CONFIG_FILE"
      else
        bundle exec puma
      fi

    echo "done server is running"
    ;;

  stop)
    echo "Stopping puma..."
      /bin/bash --login -c " kill -s SIGTERM `cat $PUMA_PID_FILE` "
      echo "Killed puma PID `cat $PUMA_PID_FILE`"
      rm -f $PUMA_PID_FILE
      echo "removed $PUMA_PID_FILE"

      if [ -e $PUMA_SOCKET ] ; then # if socket exists
        rm -f $PUMA_SOCKET
        echo "removed  $PUMA_SOCKET"
      fi
      if [ -e $PUMA_STATE ] ; then # if STATE exists
        rm -f $PUMA_STATE
        echo "removed  $PUMA_STATE"
      fi

      rm -f $PUMA_SOCKET

    echo "done"
    ;;

  restart)
    if puma_is_running ; then
      echo "Hot-restarting puma..."
       /bin/bash --login -c "kill -s SIGUSR2 `cat $PUMA_PID_FILE`"
        echo "Killed puma PID `cat $PUMA_PID_FILE`"

      echo "Doublechecking the process restart..."
      sleep 5
      if puma_is_running ; then
        echo "done"
        exit 0
      else
        echo "Puma restart failed :/"
      fi
    fi

    echo "Trying cold reboot"
    bin/puma.sh start
    ;;

  *)
    echo "Usage: bin/puma.sh {start|stop|restart}" >&2
    ;;
esac
