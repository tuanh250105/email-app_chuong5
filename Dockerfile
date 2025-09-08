# Sử dụng Tomcat + JDK 17
FROM tomcat:9.0-jdk17

# Xóa webapps mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy nguyên thư mục web (đã có WEB-INF/classes, JSP, …)
COPY web /usr/local/tomcat/webapps/ROOT

# Mở cổng 8080
EXPOSE 8080
