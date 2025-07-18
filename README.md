# SEO-Blogs - Modern Blog Platform

SEO-Blogs is a modern, fast, and SEO-optimized blog platform built with Astro and Supabase. It features a clean design, excellent performance, and is designed to rank well in search engines.

## ✨ Features

- 🚀 **Blazing fast performance** with Astro and minimal JavaScript
- 📱 **Fully responsive** design optimized for all devices
- 🔍 **SEO optimized** with meta tags, structured data, and sitemaps
- 🗂️ **Category and tag** organization for content
- 🔎 **Search functionality** powered by Fuse.js
- 📊 **Supabase integration** for content management
- 🌓 **Dark mode support** for better reading experience
- 📝 **Rich content formatting** with Tailwind Typography

## 👣 Getting Started

### Prerequisites

- Node.js (v18 or later recommended)
- npm or yarn
- A Supabase account

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/James-CodeX/SEO-Blogs.git
   cd SEO-Blogs
   ```

2. Install dependencies:
   ```bash
   npm install
   # or
   yarn
   ```

3. Create a `.env` file in the root directory with your Supabase credentials (see Supabase setup section below).

4. Start the development server:
   ```bash
   npm run dev
   # or
   yarn dev
   ```

5. Open your browser and navigate to `http://localhost:4321`

## 🚀 Project Structure

The project is organized as follows:

```text
/
├── public/              # Static assets
├── src/
│   ├── assets/          # Images and other assets
│   ├── components/      # Reusable UI components
│   │   ├── BlogCard.astro
│   │   ├── BlogGrid.astro
│   │   ├── Footer.astro
│   │   ├── Hero.astro
│   │   ├── Navigation.astro
│   │   └── SEO.astro
│   ├── layouts/         # Page layouts
│   │   ├── BaseLayout.astro
│   │   └── Layout.astro
│   ├── lib/             # Utility functions
│   │   └── supabase.ts  # Supabase client and database functions
│   └── pages/           # Page components and routes
│       ├── blog/        # Blog post pages
│       │   └── [slug].astro
│       ├── category/    # Category pages
│       │   └── [category].astro
│       ├── index.astro  # Homepage
│       ├── rss.xml.js   # RSS feed
│       └── search.astro # Search page
├── supabase/            # Supabase configuration
│   └── migrations/      # Database migrations
└── package.json
```

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |

## 🔑 Setting Up Supabase

This project uses Supabase as its backend. To set it up:

1. Create a new Supabase project at [supabase.com](https://supabase.com/)
2. Set up environment variables in a `.env` file:

```env
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

3. Run the migration in the `supabase/migrations` directory to set up your database schema

## 👨‍💻 Database Structure

The project uses the following database tables:

1. **posts** - Blog post content
   - id, title, slug, description, content, image, category, tags, author, read_time, featured, published, published_at, created_at, updated_at

2. **categories** - Blog categories
   - id, name, slug, description, created_at

3. **tags** - Blog tags
   - id, name, slug, created_at

## 💬 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 🔍 SEO Features

- Meta tags for social sharing
- Structured data for better search engine understanding
- Sitemap generation
- RSS feed
- Semantic HTML
- Optimized page load times

## 📃 License

This project is licensed under the MIT License - see the LICENSE file for details.
