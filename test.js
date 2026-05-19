const { PrismaClient } = require('./db-client');
const prisma = new PrismaClient();

async function main() {
    console.log("--- Запуск тестування Prisma Client ---");

    const user = await prisma.users.create({
        data: {
            user_name: "Коваленко",
            user_surname: "Семен",
            user_country: "Ukraine",
            user_email: "semen." + Date.now() + "@gmail.com",
            developers: {
                create: { is_searching_job: true }
            }
        }
    });
    console.log("Успішно створено користувача (з дефолтним балансом):", user);

    const category = await prisma.categories.create({
        data: { category_name: "QA Automation " + Date.now() }
    });

    const project = await prisma.projects.create({
        data: {
            project_name: "Autotests Framework",
            project_description: "Selenium + NodeJS package",
            project_url: "github.com/oleksiy/autotests",
            dev_id: user.user_id,
            category_id: category.category_id
        }
    });

    const review = await prisma.reviews.create({
        data: {
            rating: 5,
            comment: "Чудова архітектура тестів!",
            project_id: project.project_id
        }
    });
    console.log("Успішно додано відгук у нову таблицю:", review);

    const finalData = await prisma.projects.findUnique({
        where: { project_id: project.project_id },
        include: { reviews: true }
    });
    console.log("\nОтримані дані проєкту разом із відгуками з БД:");
    console.dir(finalData, { depth: null });
}

main()
    .catch(e => console.error("Помилка під час виконання:", e))
    .finally(async () => await prisma.$disconnect());