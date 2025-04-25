-- CreateTable
CREATE TABLE "BL_Home" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "BL_Home_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BL_User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT,
    "emailVerified" TIMESTAMP(3),
    "image" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "homeId" TEXT,

    CONSTRAINT "BL_User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BL_Expense" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "is_repeat" BOOLEAN NOT NULL,
    "userId" TEXT NOT NULL,
    "typeId" TEXT NOT NULL,
    "homeId" TEXT,

    CONSTRAINT "BL_Expense_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BL_Type" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "BL_Type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BL_Account" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "BL_Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BL_Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BL_Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BL_VerificationToken" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "BL_User_email_key" ON "BL_User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "BL_Type_name_key" ON "BL_Type"("name");

-- CreateIndex
CREATE UNIQUE INDEX "BL_Account_provider_providerAccountId_key" ON "BL_Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "BL_Session_sessionToken_key" ON "BL_Session"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "BL_VerificationToken_token_key" ON "BL_VerificationToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "BL_VerificationToken_identifier_token_key" ON "BL_VerificationToken"("identifier", "token");

-- AddForeignKey
ALTER TABLE "BL_User" ADD CONSTRAINT "BL_User_homeId_fkey" FOREIGN KEY ("homeId") REFERENCES "BL_Home"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BL_Expense" ADD CONSTRAINT "BL_Expense_userId_fkey" FOREIGN KEY ("userId") REFERENCES "BL_User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BL_Expense" ADD CONSTRAINT "BL_Expense_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "BL_Type"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BL_Expense" ADD CONSTRAINT "BL_Expense_homeId_fkey" FOREIGN KEY ("homeId") REFERENCES "BL_Home"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BL_Account" ADD CONSTRAINT "BL_Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "BL_User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BL_Session" ADD CONSTRAINT "BL_Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "BL_User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
