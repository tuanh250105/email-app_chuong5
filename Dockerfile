# Sử dụng Tomcat chính thức
FROM tomcat:9.0-jdk17

# Xóa webapps mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy app của bạn vào Tomcat (chú ý build ra WAR hoặc copy web folder)
COPY web /usr/local/tomcat/webapps/ch05_ex2_email

# Expose port 8080 (Render sẽ tự động map)
EXPOSE 8080
