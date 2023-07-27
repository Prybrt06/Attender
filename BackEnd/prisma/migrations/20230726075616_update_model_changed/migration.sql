/*
  Warnings:

  - Added the required column `belongsToUserId` to the `Update` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Subject" ALTER COLUMN "totalClasses" SET DEFAULT 0,
ALTER COLUMN "attendedClasses" SET DEFAULT 0;

-- AlterTable
ALTER TABLE "Update" ADD COLUMN     "belongsToUserId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "Update" ADD CONSTRAINT "Update_belongsToUserId_fkey" FOREIGN KEY ("belongsToUserId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
