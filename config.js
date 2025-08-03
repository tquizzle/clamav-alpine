// config.js: basic config for docmd
module.exports = {
  // Core Site Metadata
  siteTitle: 'ClamAV Alpine Documentation', // Title of your site, used in <title> tag and header
  // Define a base URL for your site, crucial for SEO and absolute paths
  // No trailing slash
  siteUrl: '', // Replace with your actual deployed URL

  // Logo Configuration
  logo: {
    light: '/assets/images/clamav-docker-removebg-preview.png', // Path relative to outputDir root
    dark: '/assets/images/clamav-docker-removebg-preview.png',   // Path relative to outputDir root
    alt: 'ClamAV Docker Alpine',                      // Alt text for the logo
    href: '/clamav-alpine',                              // Link for the logo, defaults to site root
  },

  // Directory Configuration
  srcDir: 'docs',       // Source directory for Markdown files
  outputDir: 'site',    // Directory for generated static site

  // Sidebar Configuration
  sidebar: {
    collapsible: true,        // or false to disable
    defaultCollapsed: false,  // or true to start collapsed
  },

  // Theme Configuration
  theme: {
    name: 'sky',            // Themes: 'default', 'sky'
    defaultMode: 'light',   // Initial color mode: 'light' or 'dark'
    enableModeToggle: true, // Show UI button to toggle light/dark modes
    positionMode: 'bottom', // 'top' or 'bottom' for the theme toggle
    customCss: [            // Array of paths to custom CSS files
      // '/assets/css/custom.css', // Custom TOC styles
    ]
  },

  // Custom JavaScript Files
  customJs: [  // Array of paths to custom JS files, loaded at end of body
    // '/assets/js/custom-script.js', // Paths relative to outputDir root
    '/assets/js/docmd-image-lightbox.js', // Image lightbox functionality
  ],

  // Content Processing
  autoTitleFromH1: true, // Set to true to automatically use the first H1 as page title

  // Plugins Configuration
  // Plugins are configured here. docmd will look for these keys.
  plugins: {
    // SEO Plugin Configuration
    // Most SEO data is pulled from page frontmatter (title, description, image, etc.)
    // These are fallbacks or site-wide settings.
    seo: {
      // Default meta description if a page doesn't have one in its frontmatter
      defaultDescription: 'This container allows you a very simple way to scan a mounted directory using clamscan. It will always update the ClamAV Database, by using the standard freshclam before running clamscan. If the local ClamAV Database is up-to-date, it will check and continue.',
      openGraph: { // For Facebook, LinkedIn, etc.
        // siteName: 'docmd Documentation', // Optional, defaults to config.siteTitle
        // Default image for og:image if not specified in page frontmatter
        // Path relative to outputDir root
        defaultImage: '/assets/images/docmd-preview.png',
      },
      twitter: { // For Twitter Cards
        cardType: 'summary_large_image',     // 'summary', 'summary_large_image'
        // siteUsername: '@docmd_handle',    // Your site's Twitter handle (optional)
        // creatorUsername: '@your_handle',  // Default author handle (optional, can be overridden in frontmatter)
      }
    },
    // Analytics Plugin Configuration
    analytics: {
      // Google Analytics 4 (GA4)
      googleV4: {
        measurementId: 'G-df' // Replace with your actual GA4 Measurement ID
      }
    },
    // Enable Sitemap plugin
    sitemap: {
      defaultChangefreq: 'weekly',
      defaultPriority: 0.8
    }
    // Add other future plugin configurations here by their key
  },

  // Navigation Structure (Sidebar)
  // Icons are kebab-case names from Lucide Icons (https://lucide.dev/)
  navigation: [
      { title: 'Welcome', path: '/', icon: 'home' }, // Corresponds to docs/index.md
      {
        title: 'Getting Started',
        icon: 'rocket',
        path: '#',
        children: [
          { title: 'Local Scan Mode', path: '#local-scan-mode', icon: 'scroll', external: false },
          { title: 'Server Mode', path: '#server-mode', icon: 'download', external: false },
          { title: 'Client Mode', path: '#client-usage', icon: 'upload', external: false },
        ],
      },
            {
        title: 'Standard Usage',
        icon: 'nested',
        path: '#standard-usage',
        children: [
          { title: 'Standard Usage', path: '#standard-usage', icon: 'play', external: false },
          { title: 'Post Arguments', path: '#post-args', icon: 'layout-template', external: false },
        ],
      },

      // External links:
      { title: 'GitHub', path: 'https://github.com/tquizzle', icon: 'github', external: true },
    ],

  // Sponsor Ribbon Configuration
  Sponsor: {
    enabled: true,
    title: 'Support me',
    link: 'https://github.com/sponsors/tquizzle',
  },

  // Footer Configuration
  // Markdown is supported here.
  footer: '© ' + new Date().getFullYear() + ' ClamAV-Alpine by TQuizzle.',

  // Favicon Configuration
  // Path relative to outputDir root
  favicon: '/assets/images/clamav-docker.ico',
};
