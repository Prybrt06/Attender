-- DropForeignKey
ALTER TABLE "Subject" DROP CONSTRAINT "Subject_belongsToId_fkey";

-- DropForeignKey
ALTER TABLE "Update" DROP CONSTRAINT "Update_belongsToUserId_fkey";

-- DropForeignKey
ALTER TABLE "Update" DROP CONSTRAINT "Update_subjectId_fkey";

-- AddForeignKey
ALTER TABLE "Subject" ADD CONSTRAINT "Subject_belongsToId_fkey" FOREIGN KEY ("belongsToId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Update" ADD CONSTRAINT "Update_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "Subject"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Update" ADD CONSTRAINT "Update_belongsToUserId_fkey" FOREIGN KEY ("belongsToUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
