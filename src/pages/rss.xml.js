import rss from '@astrojs/rss';
import { getAllPosts } from '../lib/supabase';

export async function GET(context) {
  const posts = await getAllPosts();

  return rss({
    title: 'Modern Blog',
    description: 'A modern blog featuring insights on technology, development, and design.',
    site: context.site,
    items: posts.map(post => ({
      title: post.title,
      description: post.description,
      link: `/blog/${post.slug}`,
      pubDate: new Date(post.published_at),
      author: post.author,
      categories: [post.category, ...post.tags],
    })),
    customData: `<language>en-us</language>`,
  });
}