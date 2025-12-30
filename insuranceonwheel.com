# Redirect HTTP → HTTPS
server {
    listen 80;
    server_name insuranceonwheel.com www.insuranceonwheel.com;
    return 301 https://insuranceonwheel.com$request_uri;
}

# HTTPS Server
server {
    listen 443 ssl;
    server_name insuranceonwheel.com www.insuranceonwheel.com;

    root /var/www/insuranceonwheel.com;
    index index.html index.htm;

    ssl_certificate /etc/letsencrypt/live/insuranceonwheel.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/insuranceonwheel.com/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;

    location / {
        try_files $uri $uri/ /index.html;
    }
}

