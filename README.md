# International Job Board

A full-stack job aggregator built for international students and visa seekers. Scrapes remote job listings, flags roles that mention visa sponsorship, and presents them in a searchable, filterable UI.

---

## Tech Stack

- **Backend:** Ruby on Rails 8 (API mode), PostgreSQL
- **Frontend:** React + Vite
- **Scraper:** HTTParty hitting the RemoteOK public API
- **Deployment:** Render (API), Vercel (Frontend)

---

## Features

-  One-click job scraping from RemoteOK
-  Automatic visa-friendly detection via keyword matching (`sponsor`, `visa`, `work rights`, `international students`, `relocation`)
-  Search by title, company, or location
-  Clean descriptions — HTML tags, encoding artifacts, and spam text stripped on ingestion
-  Duplicate prevention via unique index on `source_url`

---

## Getting Started

### Prerequisites

- Ruby 3.x
- Rails 8.x
- PostgreSQL
- Node.js + npm

### Backend Setup

```bash
git clone https://github.com/your-username/job-aggregator.git
cd job-aggregator

bundle install
rails db:create db:migrate
rails server
```

The API will be available at `http://localhost:3000`.

### Frontend Setup

```bash
cd job-aggregator-frontend
npm install
npm run dev
```

The frontend will be available at `http://localhost:5173`.

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/jobs` | List all scraped jobs |
| GET | `/api/v1/jobs/:id` | Get a single job |
| PATCH | `/api/v1/jobs/:id` | Update a job (e.g. visa_friendly flag) |
| POST | `/api/v1/scrape` | Trigger a fresh scrape |

---

## How the Scraper Works

Hitting `POST /api/v1/scrape` calls `JobScraper`, which:

1. Fetches job listings from the [RemoteOK API](https://remoteok.com/api/)
2. Cleans each description (strips HTML, fixes encoding, removes spam)
3. Detects visa-friendliness via keyword matching on the description
4. Uses `find_or_create_by(source_url:)` to avoid duplicates

---

## Project Structure

```
job-aggregator/
├── app/
│   ├── controllers/api/v1/jobs_controller.rb
│   ├── models/job.rb
│   └── services/job_scraper.rb
├── config/
│   ├── routes.rb
│   └── initializers/cors.rb
└── db/
    └── migrate/

job-aggregator-frontend/
└── src/
    └── App.jsx
```

---

## Roadmap

- [ ] Add more job sources (Seek, LinkedIn, Indeed)
- [ ] Filter by location (Australia-specific roles)
- [ ] User accounts with saved jobs and application tracking
- [ ] Email alerts for new visa-friendly listings
- [ ] Scheduled scraping with cron/Sidekiq

---

## License

MIT
