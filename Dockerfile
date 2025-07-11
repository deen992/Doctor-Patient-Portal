FROM tomcat:9.0-jdk11

# Clean existing apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR
COPY target/Doctor-Patient-Portal.war /usr/local/tomcat/webapps/ROOT.war

# Set Tomcat to listen correctly
ENV CATALINA_OPTS="-Djava.security.egd=file:/dev/./urandom"

EXPOSE 8080

CMD ["catalina.sh", "run"]
