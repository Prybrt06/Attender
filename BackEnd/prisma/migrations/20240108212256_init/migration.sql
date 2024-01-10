-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "mail" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subject" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "subjectCode" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "belongsToId" TEXT NOT NULL,
    "totalClasses" INTEGER NOT NULL DEFAULT 0,
    "attendedClasses" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Subject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Update" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isAttended" BOOLEAN NOT NULL,
    "subjectId" TEXT NOT NULL,
    "belongsToUserId" TEXT NOT NULL,

    CONSTRAINT "Update_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Subject_id_belongsToId_key" ON "Subject"("id", "belongsToId");

-- AddForeignKey
ALTER TABLE "Subject" ADD CONSTRAINT "Subject_belongsToId_fkey" FOREIGN KEY ("belongsToId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Update" ADD CONSTRAINT "Update_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "Subject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Update" ADD CONSTRAINT "Update_belongsToUserId_fkey" FOREIGN KEY ("belongsToUserId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
