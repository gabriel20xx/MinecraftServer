#!/bin/sh

set x

cd /

if [ ! -d /app ]; then
  mkdir -p /app
fi

cd /data

if [ ! -f /app/eula.txt ]; then
  cp eula.txt /app
fi

if [ ! -f /app/spigot-1.20.1.jar ]; then
  cp spigot-1.20.1.jar /app
fi

if [ ! -f /app/server.properties ]; then
  cp server.properties /app
fi

cd /app

if [ -n "$EULA" ]; then
  sed -i "s/eula=.*/eula=$EULA/" eula.txt
fi

if [ -n "$MOTD" ]; then
  sed -i "s/motd=.*/motd=\"$MOTD\"/" server.properties
fi

# Fork the process to run the 'java' command in the background
exec java -Xms$MIN_MEM -Xmx$MAX_MEM -jar spigot-1.20.1.jar nogui &

# Wait for the server to start
sleep 180

# Execute the desired command
echo "Executing commands..."

IFS=','  # Setting the Internal Field Separator to comma
for name in $OPS; do
  screen -S minecraft -p 0 -X stuff "op $name$(printf \\r)"
done

# Keep the script running
tail -f /dev/null
