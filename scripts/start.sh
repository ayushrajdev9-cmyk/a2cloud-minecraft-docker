#!/bin/sh
set -e

PAPER_VERSION=${PAPER_VERSION:-1.21.1}
JAR=paper-${PAPER_VERSION}.jar
PAPER_URL="https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/latest"

if [ ! -f "$JAR" ]; then
  echo "Downloading Paper ${PAPER_VERSION}..."
  BUILD=$(curl -fsSL "$PAPER_URL" | sed -n 's/.*"build":[[:space:]]*\([0-9]*\).*/\1/p')
  curl -fsSL -o "$JAR" "https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${BUILD}/downloads/paper-${PAPER_VERSION}-${BUILD}.jar"
fi

if [ ! -f eula.txt ]; then
  echo "eula=false" > eula.txt
fi

echo "Starting Paper ${PAPER_VERSION} with ${MEMORY} heap..."
exec java -Xms${MEMORY} -Xmx${MEMORY} \
  -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 \
  -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch \
  -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
  -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 \
  -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 \
  -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem \
  -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags="https://mcflags.emc.gs" \
  -Daikars.new.flags=true -jar "$JAR" nogui
