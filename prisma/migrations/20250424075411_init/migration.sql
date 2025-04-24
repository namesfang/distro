-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "phrase" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Tag" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "icon" TEXT NOT NULL,
    "href" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "disabled" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "Chip" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "disabled" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "Format" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "disabled" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "Bundle" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "tagId" INTEGER NOT NULL,
    "enName" TEXT NOT NULL,
    "cnName" TEXT NOT NULL,
    "iconUrl" TEXT NOT NULL,
    "entryUrl" TEXT NOT NULL,
    "pageUrl" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Bundle_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "Tag" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ChipsAndBundles" (
    "chipId" INTEGER NOT NULL,
    "bundleId" INTEGER NOT NULL,

    PRIMARY KEY ("chipId", "bundleId"),
    CONSTRAINT "ChipsAndBundles_chipId_fkey" FOREIGN KEY ("chipId") REFERENCES "Chip" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ChipsAndBundles_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "Bundle" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "FormatsAndBundles" (
    "formatId" INTEGER NOT NULL,
    "bundleId" INTEGER NOT NULL,

    PRIMARY KEY ("formatId", "bundleId"),
    CONSTRAINT "FormatsAndBundles_formatId_fkey" FOREIGN KEY ("formatId") REFERENCES "Format" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "FormatsAndBundles_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "Bundle" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Download" (
    "bundleId" INTEGER NOT NULL,
    "formatId" INTEGER NOT NULL,
    "chipId" INTEGER NOT NULL,
    "url" TEXT NOT NULL,
    "size" DECIMAL NOT NULL,
    "versionName" TEXT NOT NULL,
    "versionCode" TEXT NOT NULL,
    "tags" TEXT NOT NULL,

    PRIMARY KEY ("chipId", "formatId", "bundleId"),
    CONSTRAINT "Download_chipId_fkey" FOREIGN KEY ("chipId") REFERENCES "Chip" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Download_formatId_fkey" FOREIGN KEY ("formatId") REFERENCES "Format" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Download_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "Bundle" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
