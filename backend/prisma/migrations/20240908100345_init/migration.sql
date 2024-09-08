-- CreateTable
CREATE TABLE `Profile` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NULL,
    `pincode` VARCHAR(191) NULL,
    `addr` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `state` VARCHAR(191) NULL,
    `country` VARCHAR(191) NULL,
    `bank_account_number` VARCHAR(191) NULL,
    `account_holder_name` VARCHAR(191) NULL,
    `ifsc_code` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Profile_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
