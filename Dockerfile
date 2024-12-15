# Use the official Tomcat image with JRE 11
FROM tomcat:9-jre17

# Clean the Tomcat webapps directory to avoid old applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the build context into Tomcat's webapps folder
# Ensure that the WAR file is correctly built and located in 'target/war-files/'
COPY target/war-files/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 for the application to be accessible
EXPOSE 8080

# Start Tomcat when the container runs
CMD ["catalina.sh", "run"]
