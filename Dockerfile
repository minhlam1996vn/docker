# Sử dụng hình ảnh php 8.0 fpm
FROM php:8.0-fpm

# Cài đặt các phần mềm và tiện ích cần thiết
RUN apt-get update && \
    apt-get install -y \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    git \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Cài đặt Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Cài đặt Node.js 15
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get install -y nodejs

# Sao chép mã nguồn của Laravel vào thư mục /var/www/html
COPY . /var/www/html

# Đặt quyền sở hữu của tệp và thư mục của Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html/storage

# Thiết lập thư mục làm việc cho container
WORKDIR /var/www/html

# Expose port 9000 để có thể kết nối với nginx
EXPOSE 9000

# Bật php-fpm
CMD ["php-fpm"]
