<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Greenhouse Scraper API by Piloterr – scrape Greenhouse data as JSON" width="100%"></a>
</p>

# Greenhouse Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Greenhouse Scraper API** lets you extract public data from Greenhouse as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Greenhouse Job API** — Fetch one Greenhouse job by board/id, such as discord/8806482002, or by a job-boards.greenhouse.io job URL.
- **Greenhouse Search API** — List jobs on a Greenhouse board.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Greenhouse Job API](#greenhouse-job-api) | `/v2/greenhouse/job` | 1 | Fetch one Greenhouse job by board/id, such as discord/8806482002, or by a job-boards.greenhouse.io job URL. |
| [Greenhouse Search API](#greenhouse-search-api) | `/v2/greenhouse/search` | 1 | List jobs on a Greenhouse board. query is the board token, such as discord. keyword filters title and location. |

## Table of contents

- [How it works](#how-it-works)
- [Greenhouse Job API](#greenhouse-job-api)
- [Greenhouse Search API](#greenhouse-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Official SDKs](#official-sdks)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Greenhouse Job API

Fetch one Greenhouse job by board/id, such as discord/8806482002, or by a job-boards.greenhouse.io job URL.

`GET | POST https://api.piloterr.com/v2/greenhouse/job` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. board/id or a job URL. Example: discord/8806482002 or https://job-boards.greenhouse.io/discord/jobs/8806482002. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/greenhouse/job",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "discord/8806482002 or https://job-boards.greenhouse.io/discord/jobs/8806482002.",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type GreenhouseJob = {
  id?: number;
  url?: string;
  title?: string;
  offices?: string[];
  language?: string;
  location?: string;
  updated_at?: string;
  departments?: string[];
  description?: string;
  company_name?: string;
  requisition_id?: string;
  first_published?: string;
  application_deadline?: unknown;
};

const params = new URLSearchParams({
  "query": "discord/8806482002 or https://job-boards.greenhouse.io/discord/jobs/8806482002.",
});

const response = await fetch(`https://api.piloterr.com/v2/greenhouse/job?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as GreenhouseJob;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/greenhouse/job
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "discord/8806482002 or https://job-boards.greenhouse.io/discord/jobs/8806482002."}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": 8806482002,
  "url": "https://job-boards.greenhouse.io/discord/jobs/8806482002",
  "title": "Commercial Policy Lead",
  "offices": [
    "Remote (US)"
  ],
  "language": "en",
  "location": "San Francisco Bay Area",
  "updated_at": "2026-10-20T20:27:20-04:00",
  "departments": [
    "Policy"
  ],
  "description": "Discord has a highly engaged community of millions of daily active users who use the platform for many different reasons, but there’s one…",
  "company_name": "Discord",
  "requisition_id": "R-107406",
  "first_published": "2026-09-15T12:52:11-04:00",
  "application_deadline": null
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | integer |  |
| `url` | string |  |
| `title` | string |  |
| `offices` | string[] |  |
| `language` | string |  |
| `location` | string |  |
| `updated_at` | string |  |
| `departments` | string[] |  |
| `description` | string |  |
| `company_name` | string |  |
| `requisition_id` | string |  |
| `first_published` | string |  |
| `application_deadline` | object |  |

## Greenhouse Search API

List jobs on a Greenhouse board. query is the board token, such as discord. keyword filters title and location.

`GET | POST https://api.piloterr.com/v2/greenhouse/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Board token or a job-boards.greenhouse.io board URL. Example: discord. A job URL returns 400. |
| `keyword` | string | — | Optional. Case-insensitive filter on title and location. Example: policy. Omit it to list the whole board. |
| `page` | number | — | Optional. Page number from 1. Example: 2. Defaults to 1. Page size is 20. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/greenhouse/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "discord. A job URL returns 400.",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type GreenhouseSearch = {
  results?: {
    id?: number;
    url?: string;
    title?: string;
    language?: string;
    location?: string;
    updated_at?: string;
    company_name?: string;
    requisition_id?: string;
    first_published?: string;
    application_deadline?: unknown;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "discord. A job URL returns 400.",
});

const response = await fetch(`https://api.piloterr.com/v2/greenhouse/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as GreenhouseSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/greenhouse/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "discord. A job URL returns 400."}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": 8806482002,
      "url": "https://job-boards.greenhouse.io/discord/jobs/8806482002",
      "title": "Commercial Policy Lead",
      "language": "en",
      "location": "San Francisco Bay Area",
      "updated_at": "2026-10-20T20:27:20-04:00",
      "company_name": "Discord",
      "requisition_id": "R-107406",
      "first_published": "2026-09-15T12:52:11-04:00",
      "application_deadline": null
    }
  ],
  "pagination": {
    "next": "https://job-boards.greenhouse.io/discord?page=2",
    "page": 1,
    "per_page": 20,
    "total_pages": 3,
    "total_results": 43
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | integer |  |
| `results[].url` | string |  |
| `results[].title` | string |  |
| `results[].language` | string |  |
| `results[].location` | string |  |
| `results[].updated_at` | string |  |
| `results[].company_name` | string |  |
| `results[].requisition_id` | string |  |
| `results[].first_published` | string |  |
| `results[].application_deadline` | object |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Job | Search |
|---|---|---|
| cURL (Bash) | [`job`](examples/curl/job.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`job`](examples/php/job.php) | [`search`](examples/php/search.php) |
| C# | [`job`](examples/csharp/Job.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`job`](examples/go/job.go) | [`search`](examples/go/search.go) |
| Java | [`job`](examples/java/JobExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`job`](examples/ruby/job.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`job`](examples/nodejs/job.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Greenhouse plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Greenhouse?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/greenhouse/job` **1**, `/v2/greenhouse/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Greenhouse API return?

Each endpoint returns structured JSON: **Greenhouse Job** — `id`, `url`, `title`, `offices`, `language`, `location`; **Greenhouse Search** — `results[]`, `results[].id`, `results[].url`, `results[].title`, `results[].language`, `results[].location`.

### How do I paginate Greenhouse results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Official SDKs

Use Piloterr from your own language with a typed client:

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@piloterr/sdk`](https://www.npmjs.com/package/@piloterr/sdk) | `npm install @piloterr/sdk` |
| Python | [`piloterr`](https://pypi.org/project/piloterr/) | `pip install piloterr` |
| Go | [`piloterr-go`](https://pkg.go.dev/github.com/piloterr/piloterr-go) | `go get github.com/piloterr/piloterr-go` |
| .NET | [`Piloterr`](https://www.nuget.org/packages/Piloterr) | `dotnet add package Piloterr` |
| Ruby | [`piloterr`](https://rubygems.org/gems/piloterr) | `gem install piloterr` |
| PHP | [`piloterr/sdk`](https://packagist.org/packages/piloterr/sdk) | `composer require piloterr/sdk` |
| Java | [`piloterr-java`](https://github.com/piloterr/piloterr-java) | build from source, see its README |
| CLI | [`@piloterr/cli`](https://www.npmjs.com/package/@piloterr/cli) | `npm install -g @piloterr/cli` |
| MCP server | [`@piloterr/mcp`](https://www.npmjs.com/package/@piloterr/mcp) | `npx -y @piloterr/mcp` |

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Greenhouse is a trademark of its respective owner. This repository is not affiliated with or endorsed by Greenhouse. Examples are released under the MIT license.</sub>
