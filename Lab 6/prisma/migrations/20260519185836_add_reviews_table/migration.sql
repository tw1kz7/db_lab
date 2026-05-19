-- CreateTable
CREATE TABLE "categories" (
    "category_id" SERIAL NOT NULL,
    "category_name" VARCHAR(50) NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("category_id")
);

-- CreateTable
CREATE TABLE "companies" (
    "company_id" SERIAL NOT NULL,
    "company_name" VARCHAR(150) NOT NULL,

    CONSTRAINT "companies_pkey" PRIMARY KEY ("company_id")
);

-- CreateTable
CREATE TABLE "developer_links" (
    "link_id" SERIAL NOT NULL,
    "dev_id" INTEGER NOT NULL,
    "link_url" VARCHAR(255) NOT NULL,

    CONSTRAINT "developer_links_pkey" PRIMARY KEY ("link_id")
);

-- CreateTable
CREATE TABLE "developers" (
    "dev_id" INTEGER NOT NULL,
    "is_searching_job" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "developers_pkey" PRIMARY KEY ("dev_id")
);

-- CreateTable
CREATE TABLE "employers" (
    "employer_id" INTEGER NOT NULL,
    "company_id" INTEGER,
    "employer_position" VARCHAR(100) NOT NULL,

    CONSTRAINT "employers_pkey" PRIMARY KEY ("employer_id")
);

-- CreateTable
CREATE TABLE "projects" (
    "project_id" SERIAL NOT NULL,
    "dev_id" INTEGER NOT NULL,
    "category_id" INTEGER,
    "project_name" VARCHAR(150) NOT NULL,
    "project_description" TEXT NOT NULL,
    "project_url" VARCHAR(255) NOT NULL,
    "project_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "projects_pkey" PRIMARY KEY ("project_id")
);

-- CreateTable
CREATE TABLE "users" (
    "user_id" SERIAL NOT NULL,
    "user_name" VARCHAR(30) NOT NULL,
    "user_surname" VARCHAR(50) NOT NULL,
    "user_country" VARCHAR(100) NOT NULL,
    "user_email" VARCHAR(100) NOT NULL,
    "user_phone" VARCHAR(18) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "reviews" (
    "review_id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "project_id" INTEGER NOT NULL,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("review_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "categories_category_name_key" ON "categories"("category_name");

-- CreateIndex
CREATE UNIQUE INDEX "companies_company_name_key" ON "companies"("company_name");

-- CreateIndex
CREATE UNIQUE INDEX "users_user_email_key" ON "users"("user_email");

-- AddForeignKey
ALTER TABLE "developer_links" ADD CONSTRAINT "developer_links_dev_id_fkey" FOREIGN KEY ("dev_id") REFERENCES "developers"("dev_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "developers" ADD CONSTRAINT "developers_dev_id_fkey" FOREIGN KEY ("dev_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "employers" ADD CONSTRAINT "employers_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "companies"("company_id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "employers" ADD CONSTRAINT "employers_employer_id_fkey" FOREIGN KEY ("employer_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("category_id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_dev_id_fkey" FOREIGN KEY ("dev_id") REFERENCES "developers"("dev_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("project_id") ON DELETE CASCADE ON UPDATE CASCADE;
