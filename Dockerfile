FROM tomcat:9.0-jdk11

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR
COPY target/Doctor-Patient-Portal.war /usr/local/tomcat/webapps/ROOT.war

# Set Tomcat to listen on 0.0.0.0
ENV CATALINA_OPTS="-Djava.security.egd=file:/dev/./urandom -Dserver.port=8080 -Djava.awt.headless=true"

# Expose correct port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
