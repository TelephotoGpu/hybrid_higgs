#!/usr/bin/env bash
# Compile hw/spinal with scalac and run a main class, without sbt.
#
# Same Scala / SpinalHDL versions and compiler plugin as build.sbt, taken
# from the coursier cache that sbt fills. Useful where sbt cannot start
# (e.g. "User limit of inotify instances reached": sbt always creates a file
# watcher). Usage: scripts/direct-run.sh <main class> [args...]
set -euo pipefail

cd "$(dirname "$0")/.."

SCALA_VERSION=2.13.14
SPINAL_VERSION=1.11.0
M2=${COURSIER_CACHE:-$HOME/.cache/coursier/v1}/https/repo1.maven.org/maven2

jar() { # group-path artifact version
    local f="$M2/$1/$2/$3/$2-$3.jar"
    [ -f "$f" ] || { echo "direct-run: missing $f (run sbt once to fill the coursier cache)" >&2; exit 1; }
    printf '%s' "$f"
}

SCALA_LIB=$(jar org/scala-lang scala-library $SCALA_VERSION)
SCALA_REFLECT=$(jar org/scala-lang scala-reflect $SCALA_VERSION)
SCALA_COMPILER=$(jar org/scala-lang scala-compiler $SCALA_VERSION)
PLUGIN=$(jar com/github/spinalhdl spinalhdl-idsl-plugin_2.13 $SPINAL_VERSION)
CP="$SCALA_LIB:$SCALA_REFLECT"
for a in spinalhdl-core_2.13 spinalhdl-lib_2.13 spinalhdl-idsl-payload_2.13 spinalhdl-sim_2.13; do
    CP="$CP:$(jar com/github/spinalhdl $a $SPINAL_VERSION)"
done
CP="$CP:$(jar com/github/scopt scopt_2.13 4.1.0)"
CP="$CP:$(jar com/lihaoyi sourcecode_2.13 0.3.0)"
CP="$CP:$(jar commons-io commons-io 2.11.0)"
# SpinalHDL elaboration pins its thread with OpenHFT affinity
CP="$CP:$(jar net/openhft affinity 3.23.2)"
CP="$CP:$(jar net/java/dev/jna jna 5.13.0)"
CP="$CP:$(jar net/java/dev/jna jna-platform 5.13.0)"
CP="$CP:$(jar org/slf4j slf4j-api 1.7.36)"

OUT=target/direct
SRCS=$(find hw/spinal -name '*.scala' | sort)
STAMP=$OUT/.stamp
if [ ! -f "$STAMP" ] || [ -n "$(find hw/spinal -name '*.scala' -newer "$STAMP")" ]; then
    rm -rf "$OUT" && mkdir -p "$OUT"
    java -Xss8m -cp "$SCALA_LIB:$SCALA_REFLECT:$SCALA_COMPILER" scala.tools.nsc.Main \
        -deprecation -Xplugin:"$PLUGIN" -classpath "$CP" -d "$OUT" $SRCS
    touch "$STAMP"
fi

exec java -Xss16m -cp "$OUT:$CP" "$@"
