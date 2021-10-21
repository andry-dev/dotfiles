#!/bin/sh

JDT_HOME="${HOME}/.lsp/eclipse.jdt.ls"
JAR_DIR="${JDT_HOME}/org.eclipse.jdt.ls.product/target/repository"

cd "${JAR_DIR}"
pwd

JAR="./plugins/org.eclipse.equinox.launcher_1.6.300.v20210813-1054.jar"

java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.protocol=true -Dlog.level=ALL -noverify -Xmx1G -jar "$JAR" -configuration ./config_linux -data "$HOME/workspace" --add-modules=ALL-SYSTEM --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED

#GRADLE_HOME=$HOME/gradle java \
#  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
#  -Dosgi.bundles.defaultStartLevel=4 \
#  -Declipse.product=org.eclipse.jdt.ls.core.product \
#  -Dlog.protocol=true \
#  -noverify \
#  -Dlog.level=ALL \
#  -Xms1G \
#  -Xmx2G \
#  -jar "${JAR}" \
#  -configuration "./config_linux" \
#  -data "$HOME/workspace" \
#  --add-modules=ALL-SYSTEM \
#  --add-opens java.base/java.util=ALL-UNNAMED \
#  --add-opens java.base/java.lang=ALL-UNNAMED
