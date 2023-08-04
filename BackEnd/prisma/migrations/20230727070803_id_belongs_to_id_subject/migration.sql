/*
  Warnings:

  - A unique constraint covering the columns `[id,belongsToId]` on the table `Subject` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Subject_id_belongsToId_key" ON "Subject"("id", "belongsToId");
