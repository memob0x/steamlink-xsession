#!/bin/sh

username=$(whoami)

logs_path=/tmp/steamlink_logs

if [ "${username}" = "root" ];
then
  echo "Can't act as ${username}, aborting."

  exit 1
fi

kill_steamlink(){
  for pid in $(pgrep steamlink);
  do
    kill -9 $pid;
  done
}

prepare_steamlink_logs(){
  rm $logs_path

  touch $logs_path
}

launch_steamlink_with_logs(){
  sudo -u $username -E /usr/bin/steamlink > $logs_path 2>&1
}

launch(){
  echo "acting as ${username}"

  userid=$(id -u $username)

  echo "userid ${userid}"


  echo "setting XDG_RUNTIME_DIR env var"

  export XDG_RUNTIME_DIR=/run/user/$userid

  echo "runtime folder is ${XDG_RUNTIME_DIR}"


  echo "launching steamlink"

  prepare_steamlink_logs

  launch_steamlink_with_logs &

  retries=0

  while true;
  do
    logs=$(cat $logs_path)

    has_hdmi_error=$(echo $logs | grep -c "Failed to move cursor on screen HDMI1")

    has_welcome_message=$(echo $logs | grep -c "INFO: Connected to Remote Client")

    if [ "${has_hdmi_error}" = "0" ] && [ "${has_welcome_message}" = "1" ];
    then
      echo "connected!"

      break
    fi

    if [ "${has_hdmi_error}" = "0" ] && [ "${has_welcome_message}" = "0" ];
    then
      echo "connecting..."

      continue
    fi

    echo "found errors, killing steamlink."

    kill_steamlink

    retries=`expr $retries + 1`

    if [ $retries -ge 6 ];
    then
      echo "too many retries (${retries})..."

      break
    fi

    echo "restarting because of errors..."

    prepare_steamlink_logs

    launch_steamlink_with_logs &
  done

  wait

  echo "steamlink session ended gracefully, bye"
}

if [ "${1}" = "launch" ];
then
  launch

  exit 0
fi

if [ "${1}" = "kill" ];
then
  kill_steamlink

  exit 0
fi

echo "Invalid argument supplied."

exit 1
