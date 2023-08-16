FROM tomcat:8.5.4-jre8
COPY target/01-maven-web-app.war /usr/local/tomcat/webapps/01-maven-web-app.war
EXPOSE 8080