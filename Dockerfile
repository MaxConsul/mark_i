# Use official PHP image with Composer
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    zip \
    && docker-php-ext-install pdo pdo_mysql zip

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Install PHP Dependencies
RUN composer install

# Expose port 9000 (PHP -FPM default)
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]