FROM nginx:alpine

# Copy the built Flutter web app to the nginx html directory
COPY build/web /usr/share/nginx/html

# Optional: Copy custom nginx configuration
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]