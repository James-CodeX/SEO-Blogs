/*
  # Create Blog Schema

  1. New Tables
    - `posts`
      - `id` (uuid, primary key)
      - `title` (text, required)
      - `slug` (text, unique, required)
      - `description` (text, required)
      - `content` (text, required)
      - `image` (text, optional)
      - `category` (text, required)
      - `tags` (text array, required)
      - `author` (text, required)
      - `read_time` (text, required)
      - `featured` (boolean, default false)
      - `published` (boolean, default false)
      - `published_at` (timestamp)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    - `categories`
      - `id` (uuid, primary key)
      - `name` (text, unique, required)
      - `slug` (text, unique, required)
      - `description` (text, optional)
      - `created_at` (timestamp)
    - `tags`
      - `id` (uuid, primary key)
      - `name` (text, unique, required)
      - `slug` (text, unique, required)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for public read access to published posts
    - Add policies for authenticated users to manage content
*/

-- Create posts table
CREATE TABLE IF NOT EXISTS posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  slug text UNIQUE NOT NULL,
  description text NOT NULL,
  content text NOT NULL,
  image text,
  category text NOT NULL,
  tags text[] NOT NULL DEFAULT '{}',
  author text NOT NULL DEFAULT 'Blog Author',
  read_time text NOT NULL DEFAULT '5 min read',
  featured boolean DEFAULT false,
  published boolean DEFAULT true,
  published_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  slug text UNIQUE NOT NULL,
  description text,
  created_at timestamptz DEFAULT now()
);

-- Create tags table
CREATE TABLE IF NOT EXISTS tags (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  slug text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE tags ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access to published posts
CREATE POLICY "Anyone can read published posts"
  ON posts
  FOR SELECT
  USING (published = true);

CREATE POLICY "Anyone can read categories"
  ON categories
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Anyone can read tags"
  ON tags
  FOR SELECT
  TO public
  USING (true);

-- Create policies for authenticated users to manage content
CREATE POLICY "Authenticated users can insert posts"
  ON posts
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update posts"
  ON posts
  FOR UPDATE
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can delete posts"
  ON posts
  FOR DELETE
  TO authenticated
  USING (true);

-- Insert sample data
INSERT INTO categories (name, slug, description) VALUES
  ('Coding', 'coding', 'Programming tutorials and coding best practices'),
  ('Development', 'development', 'Software development insights and methodologies'),
  ('Design', 'design', 'UI/UX design principles and creative inspiration'),
  ('Technology', 'technology', 'Latest tech trends and industry insights')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tags (name, slug) VALUES
  ('AI', 'ai'),
  ('JavaScript', 'javascript'),
  ('React', 'react'),
  ('TypeScript', 'typescript'),
  ('CSS', 'css'),
  ('Astro', 'astro'),
  ('Future', 'future'),
  ('Best Practices', 'best-practices'),
  ('Responsive', 'responsive'),
  ('Grid', 'grid'),
  ('Server Components', 'server-components'),
  ('Accessibility', 'accessibility'),
  ('Web Development', 'web-development'),
  ('Trends', 'trends'),
  ('Programming', 'programming')
ON CONFLICT (slug) DO NOTHING;

-- Insert sample posts
INSERT INTO posts (title, slug, description, content, image, category, tags, author, read_time, featured, published, published_at) VALUES
  (
    'What is Vibe Coding?',
    'what-is-vibe-coding',
    'The Next Big Thing in AI-Powered Development. If you''ve been keeping an eye on the latest trends in software development, you might have come across this exciting new paradigm.',
    '<h2>Introduction to Vibe Coding</h2><p>Vibe Coding represents a revolutionary approach to software development that combines artificial intelligence with human creativity to create more intuitive and efficient coding experiences.</p><h2>Key Features</h2><ul><li>AI-powered code suggestions</li><li>Natural language programming</li><li>Context-aware development environment</li><li>Seamless collaboration tools</li></ul><h2>Benefits of Vibe Coding</h2><p>This innovative approach to development offers numerous advantages:</p><ul><li><strong>Increased Productivity:</strong> Write code faster with intelligent suggestions</li><li><strong>Reduced Errors:</strong> AI helps catch potential issues before they become problems</li><li><strong>Better Collaboration:</strong> Natural language interfaces make code more accessible</li></ul><h2>Getting Started</h2><p>Ready to dive into Vibe Coding? Here''s what you need to know to get started with this exciting new paradigm in software development.</p>',
    'https://images.pexels.com/photos/1181263/pexels-photo-1181263.jpeg',
    'coding',
    ARRAY['ai', 'coding', 'future'],
    'Alex Chen',
    '5 min read',
    true,
    true,
    '2025-01-01T00:00:00Z'
  ),
  (
    'Modern CSS Grid Layouts',
    'modern-css-grid-layouts',
    'Learn how to create stunning, responsive layouts using CSS Grid. We''ll explore advanced techniques and real-world examples.',
    '<h2>Introduction to CSS Grid</h2><p>CSS Grid Layout is a two-dimensional layout system for the web. It lets you lay content out in rows and columns, and has many features that make building complex layouts straightforward.</p><h2>Basic Grid Concepts</h2><p>Understanding the fundamental concepts of CSS Grid is essential for creating effective layouts.</p><h2>Advanced Techniques</h2><p>Once you master the basics, these advanced techniques will help you create sophisticated layouts.</p>',
    'https://images.pexels.com/photos/1181677/pexels-photo-1181677.jpeg',
    'design',
    ARRAY['css', 'grid', 'responsive'],
    'Sarah Johnson',
    '8 min read',
    false,
    true,
    '2024-12-28T00:00:00Z'
  ),
  (
    'React Server Components Explained',
    'react-server-components-explained',
    'Dive deep into React Server Components and understand how they''re changing the way we build React applications.',
    '<h2>What are React Server Components?</h2><p>React Server Components represent a new paradigm in React development, allowing components to render on the server.</p><h2>Benefits and Use Cases</h2><p>Server Components offer several advantages for modern web applications.</p>',
    'https://images.pexels.com/photos/1181271/pexels-photo-1181271.jpeg',
    'development',
    ARRAY['react', 'server-components', 'javascript'],
    'Mike Rodriguez',
    '12 min read',
    false,
    true,
    '2024-12-25T00:00:00Z'
  ),
  (
    'Building Accessible Web Applications',
    'building-accessible-web-applications',
    'A comprehensive guide to web accessibility. Learn how to make your applications usable by everyone.',
    '<h2>Why Accessibility Matters</h2><p>Web accessibility ensures that websites and applications are usable by people with disabilities.</p><h2>Key Principles</h2><p>The WCAG guidelines provide a framework for creating accessible web content.</p>',
    'https://images.pexels.com/photos/1181244/pexels-photo-1181244.jpeg',
    'development',
    ARRAY['accessibility', 'web-development', 'best-practices'],
    'Emma Davis',
    '10 min read',
    false,
    true,
    '2024-12-22T00:00:00Z'
  ),
  (
    'The Future of Web Development',
    'future-of-web-development',
    'Exploring emerging technologies and trends that will shape the future of web development in 2025 and beyond.',
    '<h2>Emerging Technologies</h2><p>The web development landscape is constantly evolving with new technologies and frameworks.</p><h2>Trends to Watch</h2><p>These trends will shape how we build web applications in the coming years.</p>',
    'https://images.pexels.com/photos/1181280/pexels-photo-1181280.jpeg',
    'technology',
    ARRAY['future', 'web-development', 'trends'],
    'David Kim',
    '15 min read',
    false,
    true,
    '2024-12-20T00:00:00Z'
  ),
  (
    'Mastering TypeScript',
    'mastering-typescript',
    'From basics to advanced patterns, learn everything you need to know about TypeScript to write better code.',
    '<h2>TypeScript Fundamentals</h2><p>TypeScript adds static type definitions to JavaScript, enabling better tooling and error detection.</p><h2>Advanced Patterns</h2><p>Learn advanced TypeScript patterns for building robust applications.</p>',
    'https://images.pexels.com/photos/1181298/pexels-photo-1181298.jpeg',
    'coding',
    ARRAY['typescript', 'programming', 'best-practices'],
    'Lisa Wang',
    '20 min read',
    false,
    true,
    '2024-12-18T00:00:00Z'
  )
ON CONFLICT (slug) DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_posts_published ON posts(published, published_at DESC);
CREATE INDEX IF NOT EXISTS idx_posts_category ON posts(category);
CREATE INDEX IF NOT EXISTS idx_posts_slug ON posts(slug);
CREATE INDEX IF NOT EXISTS idx_posts_featured ON posts(featured);
CREATE INDEX IF NOT EXISTS idx_categories_slug ON categories(slug);
CREATE INDEX IF NOT EXISTS idx_tags_slug ON tags(slug);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_posts_updated_at BEFORE UPDATE ON posts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();