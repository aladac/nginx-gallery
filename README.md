# nginx-gallery
A simple photo / video gallery using only XSLT stylesheet for nginx'es autoindex function.

Uses:
- <a target="_blank" href="https://tailwindcss.com">TailwindCSS</a>
- <a target="_blank" href="https://fontawesome.com">FontAwesome</a>

# Credit
- Breadcrumbs taken from
<a href="https://github.com/jbox-web/nginx-index-template">this GitHub project</a>
- Gallery taken from
<a target="_blank" href="https://stackoverflow.com/questions/39575873/is-there-a-way-to-create-a-simple-static-image-gallery-in-nginx-without-any-thir">this stack question</a>
# Sample Configuration
```nginx
server {
    listen 80;
    listen [::]:80;

    # If using default cert generated with certbot
    #
    # ssl_certificate /etc/letsencrypt/live/your.server.domain/fullchain.pem;
    # ssl_certificate_key /etc/letsencrypt/live/your.server.domain/privkey.pem;
    #
    # listen 443 ssl;
    # listen [::]:443 ssl;

    root /var/www/nginx-gallery;

    server_name your.server.domain;

    location / {
        xslt_string_param title $1;
        autoindex on;
        autoindex_format xml;
        xslt_stylesheet /etc/nginx/nginx-gallery.xslt path='$uri';
    }
}
```
