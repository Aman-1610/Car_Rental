# Use an official Tomcat image with a specific JDK version.
# Tomcat 9 is generally good for projects using javax.servlet.* (Servlet API 4.0).
# If your project was built against Jakarta EE (jakarta.servlet.*), you'd use Tomcat 10.1+.
# Assuming your project targets Java 11 (as per jdk11 in the image name).
# Adjust if your project requires a different Java version (e.g., jdk8, jdk17).
FROM tomcat:9.0-jdk11-openjdk

# Optional: Set a maintainer label
LABEL maintainer="amandiv2345@gmail.com"

# Optional: Set environment variables if needed by Tomcat or your app (though app-specific ones are better set in Render UI)
# ENV JAVA_OPTS="-Xms512m -Xmx1024m"

# Remove default webapps that come with the Tomcat image to keep it clean
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your project's WAR file from the 'dist' directory (relative to Dockerfile context)
# into Tomcat's webapps directory.
# Replace 'Car_Rental.war' with the exact name of your WAR file generated by NetBeans.
# By naming it ROOT.war, your application will be deployed to the root context path (/).
# So, it will be accessible at https://your-app-name.onrender.com/
# instead of https://your-app-name.onrender.com/Car_Rental/
COPY dist/Car_Rental.war /usr/local/tomcat/webapps/ROOT.war

# If you wanted to deploy it under the context path /Car_Rental, you would use:
# COPY dist/Car_Rental.war /usr/local/tomcat/webapps/Car_Rental.war

# Expose the port Tomcat runs on internally within the container
EXPOSE 8080

# The command to run when the container starts.
# catalina.sh run starts Tomcat in the foreground, which is standard for containers.
CMD ["catalina.sh", "run"]