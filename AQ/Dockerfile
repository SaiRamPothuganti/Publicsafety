FROM fnproject/fn-java-fdk-build:jdk11-1.0.98 as build-stage
WORKDIR /function
ENV MAVEN_OPTS -Dhttp.proxyHost=www-proxy-lon.uk.oracle.com -Dhttp.proxyPort=80 -Dhttps.proxyHost=www-proxy-lon.uk.oracle.com -Dhttps.proxyPort=80 -Dhttp.nonProxyHosts=localhost|127.0.0.1|10.167.103.241|artifactory-slc.oraclecorp.com|192.168.99.100|*.oraclecorp.com|*.oracle.com|*.grungy.usi|ocliffe-pc.local -Dmaven.repo.local=/usr/share/maven/ref/repository
ADD pom.xml /function/pom.xml
RUN ["mvn", "package", "dependency:copy-dependencies", "-DincludeScope=runtime", "-DskipTests=true", "-Dmdep.prependGroupId=true", "-DoutputDirectory=target", "--fail-never"]
ADD src /function/src
RUN ["mvn", "package"]
FROM fnproject/fn-java-fdk:jre11-1.0.98
WORKDIR /function
COPY --from=build-stage /function/target/*.jar /function/app/
CMD ["com.example.fn.HelloFunction::handleRequest"]