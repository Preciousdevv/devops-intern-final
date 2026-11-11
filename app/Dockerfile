
# Use a pinned, unprivileged NGINX Alpine image
FROM nginxinc/nginx-unprivileged:1.27-alpine

# Build ID supplied during docker build
ARG BUILD_SHA=local

# Copy application files into the image
COPY app/index.html /usr/share/nginx/html/index.html
COPY app/nginx.conf /etc/nginx/conf.d/default.conf

# Replace the build ID placeholder
USER root
RUN sed -i "s/BUILD_ID_PLACEHOLDER/${BUILD_SHA}/g" /usr/share/nginx/html/index.html

# Run NGINX as a non-root user
USER 101

# Application port
EXPOSE 8080

# Container health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
