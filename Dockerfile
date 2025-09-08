# Dùng Tomcat chính thức
FROM tomcat:9.0-jdk17

# Xóa các ứng dụng mặc định (ROOT, examples…)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR của bạn vào Tomcat
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
