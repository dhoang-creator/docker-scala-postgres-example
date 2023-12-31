FROM        ghcr.io/graalvm/graalvm-ce:java11-21.0.0.2 as assembler
LABEL       maintainer="Duy Hoang <duyhoang123@hotmail.co.uk>"
LABEL       description="http4s GraalVM assembler"

WORKDIR     assembler
# Copy only the required files to setup sbt
COPY        project/*.properties project/*.sbt project/
RUN         (SBT_VERSION=$(cat project/build.properties | cut -d '=' -f 2 | tr -d '[:space:]') \
              && curl -L -O https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz \
              && tar -xzf sbt-${SBT_VERSION}.tgz \
              && ./sbt/bin/sbt -mem 4096 sbtVersion)

# Copy the rest of the application source files
COPY        project/*.scala project/
COPY        src/ src/
COPY        build.sbt VERSION.txt ./
RUN         ./sbt/bin/sbt -mem 4096 clean stage

# ~~~~~~

FROM        ghcr.io/graalvm/graalvm-ce:java11-21.0.0.2 as packager_native
LABEL       maintainer="Duy Hoang <duyhoang123@hotmail.co.uk>"
LABEL       description="http4s GraalVM native-image packager"

WORKDIR     packager
RUN         gu install native-image
COPY        --from=assembler /assembler/target/universal/stage/lib/*.jar ./
RUN         native-image \
              --no-server \
              --class-path "*" \
              com.hhandoko.realworld.Application

# ~~~~~~

FROM        ubuntu:20.04
LABEL       maintainer="Duy Hoang <duyhoang123@hotmail.co.uk>"
LABEL       description="http4s GraalVM native-image runtime container"

WORKDIR     app
COPY        --from=packager_native /packager/realworld ./

EXPOSE      8080
ENTRYPOINT  ["./docker-scala-postges-example"]