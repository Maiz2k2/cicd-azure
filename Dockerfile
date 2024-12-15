FROM tomcat:9-jdk17

# Clean the Tomcat webapps directory to avoid old applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the Tomcat webapps directory
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Set the JVM argument to allow reflective access to the restricted class
ENV CATALINA_OPTS="--add-opens java.base/java.lang.invoke=ALL-UNNAMED"

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
