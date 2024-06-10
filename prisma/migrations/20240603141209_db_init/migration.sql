/*
  Warnings:

  - You are about to drop the column `created_at` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `post` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `password_hash` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `states_id` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `token` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `post` DROP FOREIGN KEY `Post_userId_fkey`;

-- AlterTable
ALTER TABLE `users` DROP COLUMN `created_at`,
    DROP COLUMN `status`,
    DROP COLUMN `updated_at`,
    ADD COLUMN `password_hash` VARCHAR(191) NOT NULL,
    ADD COLUMN `states_id` INTEGER NOT NULL,
    ADD COLUMN `token` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `post`;

-- CreateTable
CREATE TABLE `states` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `states_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categories` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `slug` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ads` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `categoryId` INTEGER NOT NULL,
    `price` DOUBLE NOT NULL,
    `priceNegotiable` BOOLEAN NOT NULL DEFAULT true,
    `description` VARCHAR(191) NOT NULL,
    `views` INTEGER NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_id` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `images` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `url` VARCHAR(191) NOT NULL,
    `default` BOOLEAN NOT NULL,
    `adId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_states_id_fkey` FOREIGN KEY (`states_id`) REFERENCES `states`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ads` ADD CONSTRAINT `ads_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ads` ADD CONSTRAINT `ads_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `categories`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `images` ADD CONSTRAINT `images_adId_fkey` FOREIGN KEY (`adId`) REFERENCES `ads`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
