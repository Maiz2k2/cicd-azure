FROM tomcat:8-jre11

# Clean the Tomcat webapps directory
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the target2 directory into Tomcat's webapps folder
COPY /home/azureuser/myagent/_work/1/s/target2/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 for the application
EXPOSE 8080

# Start Tomcat when the container runs
CMD ["catalina.sh", "run"]
