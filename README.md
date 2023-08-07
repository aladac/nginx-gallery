# nginx-gallery
A simple photo / video gallery using only XSLT stylesheet for nginx'es autoindex function.
Uses:
- [TailwindCSS](https://tailwindcss.com)
- [FontAwesome](https://fontawesome.com)

# Preview
<img width="1259" alt="Screenshot 2023-08-07 at 22 45 37" src="https://github.com/aladac/nginx-gallery/assets/1140511/ffc5f55a-525d-4eb7-be2d-15ea33b652ff">
<img width="1784" alt="Screenshot 2023-08-07 at 22 46 19" src="https://github.com/aladac/nginx-gallery/assets/1140511/0fb90d47-5ab1-4253-b8a1-ba17c2fd3ad9">
<img width="1763" alt="Screenshot 2023-08-07 at 22 47 38" src="https://github.com/aladac/nginx-gallery/assets/1140511/ab56ebc0-803a-495b-b32a-b443b3396e9b">



# Credit
- Breadcrumbs taken from [this GitHub project](https://github.com/jbox-web/nginx-index-template)
- Gallery taken from [this stack post](https://stackoverflow.com/questions/39575873/is-there-a-way-to-create-a-simple-static-image-gallery-in-nginx-without-any-thir)
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
